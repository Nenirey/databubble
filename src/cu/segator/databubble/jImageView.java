package cu.segator.databubble;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.ByteBuffer;
import javax.microedition.khronos.opengles.GL10;
import android.content.Intent;
import android.content.res.AssetManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Path;
import android.graphics.PorterDuff.Mode;
import android.graphics.Rect;
import android.graphics.drawable.AnimationDrawable;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.PaintDrawable;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
//import android.support.design.widget.CollapsingToolbarLayout;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.TranslateAnimation;
import android.widget.ImageView;
import android.view.Gravity;
import android.view.MotionEvent;
import android.widget.PopupMenu;


import java.io.FileOutputStream;
import java.io.File;

//-------------------------------------------------------------------------
// jImageView
// Reviewed by TR3E on 17/10/2019
//-------------------------------------------------------------------------

public class jImageView extends ImageView {
	//Pascal Interface
	private long           PasObj   = 0;      // Pascal Obj
	private Controls        controls = null;   // Control Cass for Event
	private jCommons LAMWCommon;
	//
	private OnClickListener onClickListener;   //
	public  Bitmap          bmp      = null;   //
	public  int             mAngle   = 0;
	
	Matrix mMatrix;
	int mRadius = 20;

	boolean mRounded = false;

	private int animationDurationIn = 1500;
	private int animationDurationOut = 1500;
	private int animationMode = 0; //none, fade, LeftToRight, RightToLeft


	//Constructor
	public  jImageView(android.content.Context context, Controls ctrls, long pasobj ) {
		super(context);

		//Connect Pascal I/F
		PasObj   = pasobj;
		controls = ctrls;
		LAMWCommon = new jCommons(this,context,pasobj);
		
		if (Build.VERSION.SDK_INT >= 21) {
			//[ifdef_api21up]
	     //this.setFitsSystemWindows(true);
	     	//[endif_api21up]
		}
		
		setScaleType(ImageView.ScaleType.CENTER);
		mMatrix = new Matrix();

		//Init Event
		/*onClickListener = new OnClickListener() {
			public  void onClick(View view) {
				controls.pOnClick(PasObj,Const.Click_Default);
			}
		};

		setOnClickListener(onClickListener);*/
		//this.setWillNotDraw(false); //false = fire OnDraw after Invalited ... true = not fire onDraw... thanks to tintinux			
	}
	
	public  boolean onTouchEvent( MotionEvent event) {
	      			
		int act     = event.getAction() & MotionEvent.ACTION_MASK;
		switch(act) {
			case MotionEvent.ACTION_DOWN: {
				switch (event.getPointerCount()) {
					case 1 : { controls.pOnTouch (PasObj,Const.TouchDown,1,
							event.getX(0),event.getY(0),0,0); break; }
					default: { controls.pOnTouch (PasObj,Const.TouchDown,2,
							event.getX(0),event.getY(0),
							event.getX(1),event.getY(1));     break; }
				}
				break;}	
			case MotionEvent.ACTION_MOVE: {
				switch (event.getPointerCount()) {
					case 1 : { controls.pOnTouch (PasObj,Const.TouchMove,1,
							event.getX(0),event.getY(0),0,0); break; }
					default: { controls.pOnTouch (PasObj,Const.TouchMove,2,
							event.getX(0),event.getY(0),
							event.getX(1),event.getY(1));     break; }
				}
				break;}
			case MotionEvent.ACTION_UP: {
				
				controls.pOnClick(PasObj,Const.Click_Default);
				
				switch (event.getPointerCount()) {
					case 1 : { controls.pOnTouch (PasObj,Const.TouchUp  ,1,
							event.getX(0),event.getY(0),0,0); break; }
					default: { controls.pOnTouch (PasObj,Const.TouchUp  ,2,
							event.getX(0),event.getY(0),
							event.getX(1),event.getY(1));     break; }
				}
				break;}
			case MotionEvent.ACTION_POINTER_DOWN: {
				switch (event.getPointerCount()) {
					case 1 : { controls.pOnTouch (PasObj,Const.TouchDown,1,
							event.getX(0),event.getY(0),0,0); break; }
					default: { controls.pOnTouch (PasObj,Const.TouchDown,2,
							event.getX(0),event.getY(0),
							event.getX(1),event.getY(1));     break; }
				}
				break;}
			case MotionEvent.ACTION_POINTER_UP  : {
				
				controls.pOnClick(PasObj,Const.Click_Default);
				
				switch (event.getPointerCount()) {
					case 1 : { controls.pOnTouch (PasObj,Const.TouchUp  ,1,
							event.getX(0),event.getY(0),0,0); break; }
					default: { controls.pOnTouch (PasObj,Const.TouchUp  ,2,
							event.getX(0),event.getY(0),
							event.getX(1),event.getY(1));     break; }
				}
				break;}
		}
		return true;
	}

	public void SetLeftTopRightBottomWidthHeight(int _left, int _top, int _right, int _bottom, int _w, int _h) {
		 String tag = ""+_left+"|"+_top+"|"+_right+"|"+_bottom;
	         this.setTag(tag);  //nedd by jsRecyclerView.java
		LAMWCommon.setLeftTopRightBottomWidthHeight(_left,_top,_right,_bottom,_w,_h);
	}


	public  void SetViewParent( android.view.ViewGroup _viewgroup ) {
		LAMWCommon.setParent(_viewgroup);
	}

	//Free object except Self, Pascal Code Free the class.
	public  void Free() {
		if (bmp    != null) bmp.recycle();
		
		bmp     = null;
		
		setImageBitmap(null);
		setImageResource(0); //android.R.color.transparent;
		
		onClickListener = null;
		setOnClickListener(null);
		
		mMatrix = null;
		LAMWCommon.free();		
	}

	public void SetBitmapImage(Bitmap _bitmap, int _width, int _height) {
		
		this.setImageResource(android.R.color.transparent);
		
		bmp = Bitmap.createScaledBitmap(_bitmap, _width, _height, true);
		
		if( bmp == null ) return;
		
		bmp.setDensity( _bitmap.getDensity() );

		if (!mRounded)
		    this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		this.invalidate();
	}

	//http://stackoverflow.com/questions/10271020/bitmap-too-large-to-be-uploaded-into-a-texture
	public void SetBitmapImage(Bitmap bm) {

		this.setImageResource(android.R.color.transparent);  //erase image ??....

		if ( (bm.getHeight() > GL10.GL_MAX_TEXTURE_SIZE) || (bm.getWidth() > GL10.GL_MAX_TEXTURE_SIZE)) {
			//is is the case when the bitmap fails to load
			int nh = (int) ( bm.getHeight() * (1024.0 / bm.getWidth()) );
			
			bmp = Bitmap.createScaledBitmap(bm,1024, nh, true);
			
			if( bmp == null ) return;
			
			bmp.setDensity( bm.getDensity() );

			if (!mRounded)
				this.setImageBitmap(bmp);
			else
				this.setImageBitmap(GetRoundedShape(bmp, 0));			
		}
		else{
			// for bitmaps with dimensions that lie within the limits, load the image normally
			if (Build.VERSION.SDK_INT >= 16) {  // why??
				BitmapDrawable ob = new BitmapDrawable(this.getResources(), bm);
//[ifdef_api16up]
				this.setBackground(ob);
//[endif_api16up]
				//this.setImageBitmap(bm);
				bmp = bm;

			} else {

				if (!mRounded)
					this.setImageBitmap(bm);
				else
					this.setImageBitmap(GetRoundedShape(bm, 0));

				bmp = bm;
			}
		}
		this.invalidate();
	}

	public  void setImage(String fullPath) {
		this.setImageResource(android.R.color.transparent);
		
		if (fullPath.equals("null")) { this.setImageBitmap(null); return; };

		if( controls.GetDensityAssets() > 0 ) {
			BitmapFactory.Options bo = new BitmapFactory.Options();
			if (bo != null) {
				bo.inDensity = controls.GetDensityAssets();
				bmp = BitmapFactory.decodeFile(fullPath, bo);
			}
			else
				bmp = BitmapFactory.decodeFile(fullPath);
		}
		else
			bmp = BitmapFactory.decodeFile(fullPath);

		 if (!mRounded)
			this.setImageBitmap(bmp);
		 else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		 this.invalidate();
	}

	public void SetImageByResIdentifier(String _imageResIdentifier) {
		Drawable d = controls.GetDrawableResourceById(controls.GetDrawableResourceId(_imageResIdentifier));
		
		if( d == null ) { 
			this.setImageBitmap(null); 
			return; 
		}
		
		Bitmap b = ((BitmapDrawable)d).getBitmap();
		
		if( b == null ) return;
		
		bmp = Bitmap.createScaledBitmap(b, b.getWidth(), b.getHeight(), true);
		
		this.setImageResource(android.R.color.transparent);
		
		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));
		
		this.invalidate();
	}

	public void SetLParamWidth(int _w) {
		LAMWCommon.setLParamWidth(_w);
	}

	public void SetLParamHeight(int _h) {		
		LAMWCommon.setLParamHeight(_h);
	}

	public void SetLGravity(int _g) {
		LAMWCommon.setLGravity(_g);
	}

	public void SetLWeight(float _w) {
		LAMWCommon.setLWeight(_w);
	}

	public int GetLParamHeight() {
		return  LAMWCommon.getLParamHeight();
	}

	public int GetLParamWidth() {				
		return LAMWCommon.getLParamWidth();
	}

	public int GetBitmapHeight() {
		if (bmp != null) {
			return this.bmp.getHeight();
		} else return 0;
	}

	public int GetBitmapWidth() {
		if (bmp != null) {
			return this.bmp.getWidth();
		} else return 0;
	}

	public void AddLParamsAnchorRule(int rule) {
		LAMWCommon.addLParamsAnchorRule(rule);
	}

	public void AddLParamsParentRule(int rule) {
		LAMWCommon.addLParamsParentRule(rule);
	}

	public void SetLayoutAll(int idAnchor) {
		LAMWCommon.setLayoutAll(idAnchor);
	}

	public void ClearLayoutAll() {
		LAMWCommon.clearLayoutAll();
	}

	/*
    * TScaleType = (scaleCenter, scaleCenterCrop, scaleCenterInside, scaleFitCenter,
                  scaleFitEnd, scaleFitStart, scaleFitXY, scaleMatrix);
    ref. http://www.peachpit.com/articles/article.aspx?p=1846580&seqNum=2
         hint: If you are creating a photo-viewing application,
               you will probably want to use the center or fitCenter scale types.
    */
	public void SetScaleType(int _scaleType) {
		switch(_scaleType) {
			case 0: this.setScaleType(ImageView.ScaleType.CENTER); break;
			case 1: this.setScaleType(ImageView.ScaleType.CENTER_CROP); break;
			case 2: this.setScaleType(ImageView.ScaleType.CENTER_INSIDE); break;
			case 3: this.setScaleType(ImageView.ScaleType.FIT_CENTER); break;
			case 4: this.setScaleType(ImageView.ScaleType.FIT_END); break;
			case 5: this.setScaleType(ImageView.ScaleType.FIT_START); break;
			case 6: this.setScaleType(ImageView.ScaleType.FIT_XY); break;
			case 7: this.setScaleType(ImageView.ScaleType.MATRIX); break;
		}
	}	
	
    public void SetMatrixScaleCenter(float _scaleX, float _scaleY) {
    	
    	if( (_scaleX <= 0) || (_scaleY <= 0) ) return;
    	
    	if(this.getScaleType() != ImageView.ScaleType.MATRIX)  
			this.setScaleType(ImageView.ScaleType.MATRIX);
    	
    	SetMatrix( _scaleX, _scaleY, 0,
    			   (this.getWidth()/2) - (bmp.getWidth()*_scaleX)/2,
    			   (this.getHeight()/2) - (bmp.getHeight()*_scaleY)/2, 0, 0);
    	
	}

	public void SetMatrix(float _scaleX, float _scaleY, float _angle, float _dx, float _dy, float _px, float _py ) {
		
		if( (_scaleX <= 0) || (_scaleY <= 0) ) return;
		
		if(this.getScaleType() != ImageView.ScaleType.MATRIX)  
			this.setScaleType(ImageView.ScaleType.MATRIX);
		
		mMatrix.setScale(_scaleX, _scaleY);
		mMatrix.postRotate( _angle, _px, _py );		
		mMatrix.postTranslate( _dx, _dy );				      				
		
		this.setImageMatrix(mMatrix);
		
	}

	public void SetScale(float _scaleX, float _scaleY ) {
		if( bmp == null ) return;
		
		int newWidth = (int)(bmp.getWidth()*_scaleX);
		int newHeight = (int)(bmp.getHeight()*_scaleY);
		
		if( newWidth <= 0 ) newWidth = 1;
		if( newHeight <= 0 ) newHeight = 1;
		
		Bitmap bmpScale = Bitmap.createScaledBitmap( bmp, newWidth, newHeight, true );
		bmpScale.setDensity( bmp.getDensity() );
		
		this.setImageBitmap( bmpScale );		
	}
	
    public void SetAlpha( int value ) {
		
		if( bmp == null ) return;
		
		if( value < 0 ) value = 0;
		if( value > 255) value = 255;

		//[ifdef_api16up]
		if(Build.VERSION.SDK_INT >= 16) setImageAlpha(value);
		//[endif_api16up]

	}
    
    public void SetSaturation( float value ){
        ColorMatrix matrix = new ColorMatrix();
        
        matrix.setSaturation(value); 
        
        setColorFilter(new ColorMatrixColorFilter(matrix));
    }

	public Bitmap GetBitmapImage() {
		return bmp;
	}


	public void SetImageFromIntentResult(Intent _intentData) {
		Uri selectedImage = _intentData.getData();
		
		String[] filePathColumn = { MediaStore.Images.Media.DATA };
		
		Cursor cursor = controls.activity.getContentResolver().query(selectedImage, filePathColumn, null, null, null);
		
		cursor.moveToFirst();
		
		int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
		
		String picturePath = cursor.getString(columnIndex);
		
		cursor.close();

		if( controls.GetDensityAssets() > 0 ) {
			BitmapFactory.Options bo = new BitmapFactory.Options();
			if (bo != null) {
				bo.inDensity = controls.GetDensityAssets();
				bmp = BitmapFactory.decodeFile(picturePath, bo);
			}
			else
				bmp = BitmapFactory.decodeFile(picturePath);
		}
		else
			bmp = BitmapFactory.decodeFile(picturePath);

		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		this.invalidate();
	}

	public void SetImageThumbnailFromCamera(Intent _intentData) {
		Bundle extras = _intentData.getExtras();
		
		bmp = (Bitmap)extras.get("data");
		
		if( (bmp != null) && (controls.GetDensityAssets() > 0) )
			bmp.setDensity(controls.GetDensityAssets());

		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		this.invalidate();
	}

	//TODO Pascal
	public void SetImageFromURI(Uri _uri) {
		InputStream imageStream = null;
		try {
			imageStream = controls.activity.getContentResolver().openInputStream(_uri);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if( controls.GetDensityAssets() > 0 ) {
			BitmapFactory.Options bo = new BitmapFactory.Options();
			if (bo != null) {
				bo.inDensity = controls.GetDensityAssets();
				bmp = BitmapFactory.decodeStream(imageStream, null, bo);
			}
			else
				bmp = BitmapFactory.decodeStream(imageStream);
		}
		else
			bmp = BitmapFactory.decodeStream(imageStream);

		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		this.invalidate();

	}

	public void SetImageFromByteArray(byte[] _image) {

		if( controls.GetDensityAssets() > 0 ) {
			BitmapFactory.Options bo = new BitmapFactory.Options();
			if (bo != null) {
				bo.inDensity = controls.GetDensityAssets();
				bmp = BitmapFactory.decodeByteArray(_image, 0, _image.length, bo);
			}
			else
				bmp = BitmapFactory.decodeByteArray(_image, 0, _image.length);
		}
		else
			bmp = BitmapFactory.decodeByteArray(_image, 0, _image.length);

		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		this.invalidate();
	}

	public Bitmap GetDrawingCache() {
		
		this.setDrawingCacheEnabled(true);
		
		Bitmap b = Bitmap.createBitmap(this.getDrawingCache());
		
		this.setDrawingCacheEnabled(false);
		
		return b;
	}
	
	public void SetRoundCorner() {
		   if (this != null) {  		
			        PaintDrawable  shape =  new PaintDrawable();
			        
			        shape.setCornerRadius(mRadius);
			        
			        int color = Color.TRANSPARENT;
			        
			        Drawable background = this.getBackground();
			        
			        if (background instanceof ColorDrawable) {
			            color = ((ColorDrawable)this.getBackground()).getColor();
				        shape.setColorFilter(color, Mode.SRC_ATOP);        		           		        		        
				        //[ifdef_api16up]
				  	    if(Build.VERSION.SDK_INT >= 16) 
				             this.setBackground((Drawable)shape);
				        //[endif_api16up]			          
			        }                		  	  
		    }
	}
	
	public void SetRotation( int angle ){
		mAngle = angle;
		this.setRotation(mAngle);
	}
	
	public boolean SaveToJPG( String filePath, int cuality, int angle ){
		
		if( bmp == null ) return false;		

		File file = new File(filePath);
				
		//Overwrite file
		if( file.exists() ) if( !file.delete() ) return false;
		
		Matrix matrix = new Matrix();
	    matrix.postRotate(angle);
	    Bitmap bmpRot = Bitmap.createBitmap(bmp, 0, 0, bmp.getWidth(), bmp.getHeight(), matrix, true);			
		
		try {
			FileOutputStream fOut = new FileOutputStream(file);
			bmpRot.compress(Bitmap.CompressFormat.JPEG, cuality, fOut);
		    fOut.flush();
		    fOut.close();
		    
		    return true;
		} catch (Exception e) {
			return false;
		}
	}
	
    public boolean SaveToPNG( String filePath, int cuality, int angle ){
		
		if( bmp == null ) return false;		

		File file = new File(filePath);
		
		//Overwrite file
		if( file.exists() ) if( !file.delete() ) return false;
		
		Matrix matrix = new Matrix();
	    matrix.postRotate(angle);
	    Bitmap bmpRot = Bitmap.createBitmap(bmp, 0, 0, bmp.getWidth(), bmp.getHeight(), matrix, true);			
		
		try {
			FileOutputStream fOut = new FileOutputStream(file);
			bmpRot.compress(Bitmap.CompressFormat.PNG, cuality, fOut);
		    fOut.flush();
		    fOut.close();
		    
		    return true;
		} catch (Exception e) {
			return false;
		}
	}

	public void SetRadiusRoundCorner(int _radius) {
		mRadius =  _radius;
	}
		
	public void SetCollapseMode(int _collapsemode) {  //called on JNIPrompt
		LAMWCommon.setCollapseMode(_collapsemode);
	}

	public void	SetScrollFlag(int _collapsingScrollFlag) {
		LAMWCommon.setScrollFlag(_collapsingScrollFlag);
	}

    public void	SetFitsSystemWindows(boolean _value) {
		LAMWCommon.setFitsSystemWindows(_value);
    }

    /*
    Change the view's z order in the tree, so it's on top of other sibling views.
    Prior to KITKAT/4.4/Api 19 this method should be followed by calls to requestLayout() and invalidate()
    on the view's parent to force the parent to redraw with the new child ordering.
  */
    
	public void BringToFront() {
		 
		this.bringToFront();

		LAMWCommon.BringToFront();

		if ( (animationDurationIn > 0)  && (animationMode != 0) ) {
			switch (animationMode) {
				case 1: {
					fadeInAnimation(this, animationDurationIn);
					break;
				}
				case 2: {  //RightToLeft
					slidefromRightToLeft(this, animationDurationIn);
					break;
				}
				case 3: {  //RightToLeft
					slidefromLeftToRight3(this, animationDurationIn);
					break;
				}

			}
		}

		if (animationMode == 0)
			this.setVisibility(android.view.View.VISIBLE);
	}

	public void SetVisibilityGone() {
		LAMWCommon.setVisibilityGone();
	}

    public ByteBuffer GetByteBuffer(int _width, int _height) {	  
	    ByteBuffer graphicBuffer = ByteBuffer.allocateDirect(_width*_height*4);    
        return graphicBuffer;    
    }

    public Bitmap GetBitmapFromByteBuffer(ByteBuffer _byteBuffer, int _width, int _height) {	 
	      _byteBuffer.rewind();  //reset position
	      bmp = Bitmap.createBitmap(_width, _height, Bitmap.Config.ARGB_8888);
          bmp.copyPixelsFromBuffer(_byteBuffer);
          
          if( controls.GetDensityAssets() > 0 )
           bmp.setDensity( controls.GetDensityAssets() );
          
          return bmp;
    }

	public void SetImageFromByteBuffer(ByteBuffer _jbyteBuffer, int _width, int _height) {
		bmp = GetBitmapFromByteBuffer(_jbyteBuffer,_width,_height);

		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));

		this.invalidate();

	}

	/*
	 * Making image in circular shape
	 * http://www.androiddevelopersolutions.com/2012/09/crop-image-in-circular-shape-in-android.html
	 */
	private Bitmap GetRoundedShape(Bitmap _bitmapImage, int _diameter) {
		Bitmap sourceBitmap = _bitmapImage;
		Path path = new Path();

		int dim;
		if(_diameter == 0 ) {
			dim = sourceBitmap.getHeight();
			if (dim > sourceBitmap.getWidth()) dim = sourceBitmap.getWidth();
		}
		else {
			dim = _diameter;
			int min;

			if (sourceBitmap.getWidth() <  sourceBitmap.getHeight())
				min = sourceBitmap.getWidth();
			else
				min = sourceBitmap.getHeight();

			if (dim > min) dim = min;
		}

		int targetWidth = dim;
		int targetHeight = dim;

		Bitmap targetBitmap = Bitmap.createBitmap(targetWidth,
				targetHeight,Bitmap.Config.ARGB_8888);
		
		if( targetBitmap == null ) return null;
		
		targetBitmap.setDensity( _bitmapImage.getDensity() );

		Canvas canvas = new Canvas(targetBitmap);

		path.addCircle(((float) targetWidth - 1) / 2,
				((float) targetHeight - 1) / 2,
				(Math.min(((float) targetWidth),
						((float) targetHeight)) / 2),
				Path.Direction.CCW);

		canvas.clipPath(path);

		canvas.drawBitmap(sourceBitmap,
				new Rect(0, 0, sourceBitmap.getWidth(),
						sourceBitmap.getHeight()),
				new Rect(0, 0, targetWidth,
						targetHeight), null);
		return targetBitmap;
	}

	private Bitmap GetRoundedShape(Bitmap _bitmapImage) {
		return GetRoundedShape(_bitmapImage, 0);
	}

	public void SetRoundedShape(boolean _value) {
		mRounded = _value;
	}

	//https://www.androidhive.info/2012/07/android-loading-image-from-url-http/
//http://www.viralandroid.com/2015/11/load-image-from-url-internet-in-android.html
	   /*
    Params : The type of the parameters sent to the task upon execution  //ex. "https://s3.amazonaws.com/TranscodeAppVideos/ocean.mp4"
    Progress : The type of the progress units published during the background computation
    Result : The type of the result of the background computation
     */

	public void LoadFromURL(String _url) {
		new LoadImageTask(this).execute(_url);
	}

	class LoadImageTask extends AsyncTask<String, Void, Bitmap> {
		ImageView imgView;
		public LoadImageTask(ImageView iv) {
			imgView = iv;
		}

		@Override
		protected Bitmap doInBackground(String... args) {
			Bitmap image = null;
			try {
				if( controls.GetDensityAssets() > 0 ) {
					BitmapFactory.Options bo = new BitmapFactory.Options();
					if (bo != null) {
						bo.inDensity = controls.GetDensityAssets();
						image = BitmapFactory.decodeStream((InputStream)new URL(args[0]).getContent(), null, bo);
					}
					else
						image = BitmapFactory.decodeStream((InputStream)new URL(args[0]).getContent());
				}
				else
					image = BitmapFactory.decodeStream((InputStream)new URL(args[0]).getContent());

				//return BitmapFactory.decodeStream((InputStream)new URL(args[0]).getContent(), null, bo);
				return image;

			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		@Override
		protected void onPostExecute(Bitmap bitmap) {
			if (bitmap != null) {
				bmp = bitmap;
				imgView.setImageResource(android.R.color.transparent);
				if (!mRounded)
					imgView.setImageBitmap(bmp);
				else
					imgView.setImageBitmap(GetRoundedShape(bmp, 0));
				imgView.invalidate();
			} else {
				//
			}
		}
	}

	public void SaveToFile(String _filename) {
		
		if (bmp == null) return;
		
		Bitmap image = bmp.copy(Bitmap.Config.ARGB_8888, true);
		
		Canvas c = new Canvas(image);
		
		draw(c);
		
		FileOutputStream fos = null;
		
		try {
			fos = new FileOutputStream(_filename);
			if (fos != null) {
				if (_filename.toLowerCase().contains(".jpg"))
					image.compress(Bitmap.CompressFormat.JPEG, 90, fos);
				if (_filename.toLowerCase().contains(".png"))
					image.compress(Bitmap.CompressFormat.PNG, 100, fos);

				fos.close();
			}
		} catch (Exception e) {
			Log.e("SaveToFile", "Exception: " + e.toString());
		}
	}

	public View GetView() {
		return this;
	}

	public void ShowPopupMenu(String[] _items) {
		PopupMenu dropDownMenu = new PopupMenu(controls.activity, this);
		dropDownMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
			@Override
			public boolean onMenuItemClick(MenuItem menuItem) {
				controls.pOnImageViewPopupItemSelected(PasObj, menuItem.getTitle().toString());
				return true;
			}
		});
		//dropDownMenu.getMenu().add(caption);
		for (int i = 0; i < _items.length; i++) {
			dropDownMenu.getMenu().add(_items[i]);
		}
		dropDownMenu.show();
	}


	public void SetAnimationDurationIn(int _animationDurationIn) {
		animationDurationIn = _animationDurationIn;
	}

	public void SetAnimationDurationOut(int _animationDurationOut) {
		animationDurationOut = _animationDurationOut;
	}

	public void SetAnimationMode(int _animationMode) {
		animationMode = _animationMode;
	}

	/// https://www.codexpedia.com/android/android-fade-in-and-fade-out-animation-programatically/
	private void fadeInAnimation(final View view, int duration) {
		Animation fadeIn = new AlphaAnimation(0, 1);
		fadeIn.setInterpolator(new DecelerateInterpolator());
		fadeIn.setDuration(duration);
		fadeIn.setAnimationListener(new Animation.AnimationListener() {
			@Override
			public void onAnimationStart(Animation animation) {
			}
			@Override
			public void onAnimationEnd(Animation animation) {
				view.setVisibility(View.VISIBLE);
			}
			@Override
			public void onAnimationRepeat(Animation animation) {
			}
		});

		view.startAnimation(fadeIn);
	}

	private void fadeOutAnimation(final View view, int duration) {
		Animation fadeOut = new AlphaAnimation(1, 0);
		fadeOut.setInterpolator(new AccelerateInterpolator());
		fadeOut.setStartOffset(duration);
		fadeOut.setDuration(duration);
		fadeOut.setAnimationListener(new Animation.AnimationListener() {
			@Override
			public void onAnimationStart(Animation animation) {
			}
			@Override
			public void onAnimationEnd(Animation animation) {
				view.setVisibility(View.INVISIBLE);
			}
			@Override
			public void onAnimationRepeat(Animation animation) {
			}
		});
		view.startAnimation(fadeOut);
	}

	//https://stackoverflow.com/questions/20696801/how-to-make-a-right-to-left-animation-in-a-layout/20696822
	private void slidefromRightToLeft(View view, long duration) {
		TranslateAnimation animate;
		if (view.getHeight() == 0) {
			//controls.appLayout.getHeight(); // parent layout
			animate = new TranslateAnimation(controls.appLayout.getWidth(),
					0, 0, 0); //(xFrom,xTo, yFrom,yTo)
		} else {
			animate = new TranslateAnimation(view.getWidth(),0, 0, 0); // View for animation
		}
		animate.setDuration(duration);
		animate.setFillAfter(true);
		view.startAnimation(animate);
		view.setVisibility(View.VISIBLE); // Change visibility VISIBLE or GONE
	}

	private void slidefromLeftToRight(View view, long duration) {  //try

		TranslateAnimation animate;  //(0.0f, 0.0f, 1500.0f, 0.0f);
		if (view.getHeight() == 0) {
			//controls.appLayout.getHeight(); // parent layout
			animate = new TranslateAnimation(0,
					controls.appLayout.getWidth(), 0, 0); //(xFrom,xTo, yFrom,yTo)
		} else {
			animate = new TranslateAnimation(0,view.getWidth(), 0, 0); // View for animation
		}

		animate.setDuration(duration);
		animate.setFillAfter(true);
		view.startAnimation(animate);
		view.setVisibility(View.VISIBLE); // Change visibility VISIBLE or GONE
	}


	private void slidefromRightToLeft3(View view, long duration) {
		TranslateAnimation animate;  //(0.0f, 0.0f, 1500.0f, 0.0f);
		if (view.getHeight() == 0) {
			//controls.appLayout.getHeight(); // parent layout
			animate = new TranslateAnimation(0, -controls.appLayout.getWidth(),
					0, 0); //(xFrom,xTo, yFrom,yTo)
		} else {
			animate = new TranslateAnimation(0,-controls.appLayout.getWidth(),
					0, 0); // View for animation
		}

		animate.setDuration(duration);
		animate.setFillAfter(true);
		view.startAnimation(animate);
		view.setVisibility(View.VISIBLE); // Change visibility VISIBLE or GONE
	}

	private void slidefromLeftToRight3(View view, long duration) {  //try
		TranslateAnimation animate;  //(0.0f, 0.0f, 1500.0f, 0.0f);
		if (view.getHeight() == 0) {
			//controls.appLayout.getHeight(); // parent layout
			animate = new TranslateAnimation(-controls.appLayout.getWidth(),
					0, 0, 0); //(xFrom,xTo, yFrom,yTo)
		} else {
			animate = new TranslateAnimation(-controls.appLayout.getWidth(),0, 0, 0); // View for animation
		}

		animate.setDuration(duration);
		animate.setFillAfter(true);
		view.startAnimation(animate);
		view.setVisibility(View.VISIBLE); // Change visibility VISIBLE or GONE
	}


	private Bitmap LoadFromAssets(String strName)
	{
		Bitmap bmp;
		AssetManager assetManager = controls.activity.getAssets();
		InputStream istr = null;
		try {
			istr = assetManager.open(strName);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

		if( controls.GetDensityAssets() > 0 ) {
			BitmapFactory.Options bo = new BitmapFactory.Options();
			if (bo != null) {
				bo.inDensity = controls.GetDensityAssets();
				bmp = BitmapFactory.decodeStream(istr, null, bo);
			}
			else
				bmp = BitmapFactory.decodeStream(istr);
		}
		else
			bmp = BitmapFactory.decodeStream(istr);

		return bmp;
	}

	public void SetImageFromAssets(String _filename) {
		bmp = LoadFromAssets(_filename);
		if (!mRounded)
			this.setImageBitmap(bmp);
		else
			this.setImageBitmap(GetRoundedShape(bmp, 0));
	}

	public void Clear() {
	    this.setImageBitmap(null);
		//this.setImageDrawable(null);
		//this.setImageResource(android.R.color.transparent);
		//ImageView.setVisibility(View.INVISIBLE)
	}

	public void SetImageDrawable(AnimationDrawable _imageAnimation) {
		if (_imageAnimation == null) { 
			this.setImageDrawable(null); 
			return; 
		}
		
		_imageAnimation.stop();
		
        if(this.getDrawable() == null) this.setImageDrawable(_imageAnimation);
        
		_imageAnimation.setOneShot(false);
		_imageAnimation.setVisible(true, true);
		_imageAnimation.start();
	}

}


