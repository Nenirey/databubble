{Hint: save all files to location: D:\lamw\projects\databubble\jni }
unit unit4;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, seekbar,
  drawingview, gridview, FPimage, FPReadPNG,
  Graphics, And_jni;
  
type

  { TAndroidModule4 }

  TAndroidModule4 = class(jForm)
    jBitmap1: jBitmap;
    jbPreview: jButton;
    jchbBold: jCheckBox;
    jchbEmoticons: jCheckBox;
    jchbColorInterface: jCheckBox;
    jchbHiddeOL: jCheckBox;
    jchbShadow: jCheckBox;
    jDrawingView_ColorPick: jDrawingView;
    jGridView1: jGridView;
    jImageView1: jImageView;
    jPAppearance: jPanel;
    jPBColor: jPanel;
    jPFColor: jPanel;
    jPSColor: jPanel;
    jsbFontSize: jSeekBar;
    jsbTransparent: jSeekBar;
    jTextView1: jTextView;
    jTextView4: jTextView;
    jtvSColor: jTextView;
    jTextView3: jTextView;
    jtvBColor: jTextView;
    jtvDrawInfo: jTextView;
    jtvFColor: jTextView;
    jtvFontSize: jTextView;
    jtvTransparent: jTextView;
    procedure jbPreviewClick(Sender: TObject);
    procedure jbShowBuubleClick(Sender: TObject);
    procedure jchbBoldClick(Sender: TObject);
    procedure jchbColorInterfaceClick(Sender: TObject);
    procedure jchbEmoticonsClick(Sender: TObject);
    procedure jchbHiddeOLClick(Sender: TObject);
    procedure jchbShadowClick(Sender: TObject);
    procedure jDrawingView_ColorPickClick(Sender: TObject; ID: integer; X,
      Y: single);
    procedure jDrawingView_ColorPickDraw(Sender: TObject; countXY: integer;
      X: array of single; Y: array of single; flingGesture: TFlingGesture;
      pinchZoomScaleState: TPinchZoomScaleState; zoomScale: single);
    procedure jDrawingView_ColorPickTouchDown(Sender: TObject;
      countXY: integer; X: array of single; Y: array of single;
      flingGesture: TFlingGesture; pinchZoomScaleState: TPinchZoomScaleState;
      zoomScale: single);
    procedure jGridView1ClickItem(Sender: TObject; ItemIndex: integer;
      itemCaption: string);
    procedure jGridView1DrawItemBitmap(Sender: TObject; itemIndex: integer;
      itemCaption: string; out bimap: JObject);
    procedure jPBColorClick(Sender: TObject);
    procedure jPSColorClick(Sender: TObject);
    procedure jPFColorClick(Sender: TObject);
    procedure jsbFontSizeProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jsbTransparentProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure fillgridcolors;
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule4: TAndroidModule4;
  gridcolorcount:integer;

implementation
  
{$R *.lfm}

uses
  unit1, unit2, unit3;

{ TAndroidModule4 }

procedure TAndroidModule4.fillgridcolors;
var
  i:TARGBColorBridge;
begin
  if gridcolorcount<1 then
  begin
    for i:=Low(TARGBColorBridge) to High(TARGBColorBridge) do
    begin
      jGridView1.Add(inttostr(gridcolorcount), '');
      inc(gridcolorcount);
    end;
    jGridView1.Add(' + ', '');
  end;
end;

procedure TAndroidModule4.jbPreviewClick(Sender: TObject);
begin
  bubbletext:='Vista previa';
  //MainModule.jtvBubble.Text:='Vista previa';
  if MainModule.jwmBubble.CanDrawOverlays() then
  begin
    if flotando=false then
    begin
      MainModule.flotar;
    end;
  end
  else
  begin
    ShowMessage('Debe conceder los permisos necesarios para mostrar contenido sobre otras aplicaciones!!!');
    MainModule.jwmBubble.RequestDrawOverlayRuntimePermission(gApp.PackageName,1006);
  end;
  //if MainModule.jAsyncTaskLogin.Running=false then
    //MainModule.jAsyncTaskLogin.Execute;
  //MainModule.DHTTPClient.Document.Position:=0;
  //MainModule.parsetemplate(tmprawcontent);
end;

procedure TAndroidModule4.jbShowBuubleClick(Sender: TObject);
begin
  //MainModule.savepreferences;
  if MainModule.jwmBubble.CanDrawOverlays() then
  begin
    if flotando=false then
    begin
     if login then
     begin
       MainModule.jTemporizador.Interval:=AndroidModule3.jsbInterval.Progress*1000;
       MainModule.jTemporizador.Enabled:=true;
       MainModule.flotar;
       Self.MoveTaskToBack(true);
     end
     else
     begin
       if (AndroidModule2.jetUser.Text<>'') and (AndroidModule2.jetPassword.Text<>'') then
       begin
         MainModule.bubblestart;
         self.MoveTaskToBack(true);
       end;
       //else
         //MainModule.jsTabLayout1.SetPosition(0);
     end;
    end
    else
    begin
     if login then
     begin
       MainModule.jTemporizador.Interval:=AndroidModule3.jsbInterval.Progress*1000;
       MainModule.jTemporizador.Enabled:=true;
       Self.MoveTaskToBack(true);
     end;
     //else
       //MainModule.jsTabLayout1.SetPosition(0);
    end;
  end
  else
  begin
    ShowMessage('Debe conceder los permisos necesarios para mostrar contenido sobre otras aplicaciones!!!');
    MainModule.jwmBubble.RequestDrawOverlayRuntimePermission(gApp.PackageName,1006);
  end;
end;

procedure TAndroidModule4.jchbBoldClick(Sender: TObject);
begin
  //MainModule.savepreferences;
  MainModule.bubblerefresh;
end;

procedure TAndroidModule4.jchbColorInterfaceClick(Sender: TObject);
begin
  colorizeinterface:=jchbColorInterface.Checked;
  MainModule.updateinterface
end;

procedure TAndroidModule4.jchbEmoticonsClick(Sender: TObject);
begin
  //MainModule.savepreferences;
  if tmprawcontent<>'' then
    MainModule.parsehtmldata(tmprawcontent);
end;

procedure TAndroidModule4.jchbHiddeOLClick(Sender: TObject);
begin
  //MainModule.savepreferences;
  hiddeol:=AndroidModule4.jchbHiddeOL.Checked;
end;

procedure TAndroidModule4.jchbShadowClick(Sender: TObject);
begin
  if jchbShadow.Checked then
    MainModule.jtvBubbleLayouting(nil, true)
  else
    MainModule.jtvBubble.SetShadowLayer(0, 0, 0, colbrDefault);
end;

procedure TAndroidModule4.jDrawingView_ColorPickClick(Sender: TObject;
  ID: integer; X, Y: single);
begin

end;

procedure TAndroidModule4.jDrawingView_ColorPickDraw(Sender: TObject;
  countXY: integer; X: array of single; Y: array of single;
  flingGesture: TFlingGesture; pinchZoomScaleState: TPinchZoomScaleState;
  zoomScale: single);
begin
  jDrawingView_ColorPick.DrawBitmap(MainModule.jBitmap_ColorPick.GetImage(),
  jDrawingView_ColorPick.Width, jDrawingView_ColorPick.Height);
  if (init_images = False) then
  begin
    init_images := True;
    if (Self.FileExists(Self.GetEnvironmentDirectoryPath(dirInternalAppStorage) +
      '/' + _color_pick_fn)) then
    begin
      //ShowMessage('Delete old resource: ' + _color_pick_fn);
      Self.DeleteFile(Self.GetEnvironmentDirectoryPath(dirInternalAppStorage),
        _color_pick_fn);
    end;
    jDrawingView_ColorPick.SaveToFile(Self.GetEnvironmentDirectoryPath(
      dirInternalAppStorage), _color_pick_fn);
    Img := TFPMemoryImage.Create(jDrawingView_ColorPick.Width,
      jDrawingView_ColorPick.Height);
    Reader := TFPReaderPNG.Create;
    Img.LoadFromFile(Self.GetEnvironmentDirectoryPath(dirInternalAppStorage) +
      '/' + _color_pick_fn, Reader);
  end;
end;

procedure TAndroidModule4.jDrawingView_ColorPickTouchDown(Sender: TObject;
  countXY: integer; X: array of single; Y: array of single;
  flingGesture: TFlingGesture; pinchZoomScaleState: TPinchZoomScaleState;
  zoomScale: single);
var
  P: TPoint;
  my_tfpcolor_color: TFPColor;
  my_tcolor_color: TColor;
  my_RGBA_color: TColorRGBA;
begin
  P := Point(Round(X[0]), Round(Y[0]));
  if (init_images) then
  begin
    my_tfpcolor_color := Img.colors[P.X, P.Y];//get touched pixel in TFPCOLOR
    my_tcolor_color := FPColorToTColor(my_tfpcolor_color);
    // convert color to  TColor (regular FPC color) - to show via
    // convet TColor to  TColorRGBA (used on LAMW:Android)
    my_RGBA_color.A := $FF; // not transparent
    my_RGBA_color.R := RED(my_tcolor_color);
    my_RGBA_color.G := GREEN(my_tcolor_color);
    my_RGBA_color.B := BLUE(my_tcolor_color);


    //Debug out touched color like #DF3456
    //ShowMessage('#' + IntToHex(Red(my_tcolor_color), 2) +
      //IntToHex(Green(my_tcolor_color), 2) + IntToHex(Blue(my_tcolor_color), 2));

    if whatpaint='bubble_font_color' then
    begin
      bubble_font_color:='$'+IntToHex(Blue(my_tcolor_color), 2)+IntToHex(Green(my_tcolor_color), 2)+IntToHex(Red(my_tcolor_color), 2);
      jPFColor.CustomColor := ARGBtoCustomColor(my_RGBA_color);
      jPFColor.BackgroundColor := colbrCustom;
    end;

    if whatpaint='bubble_shadow_color' then
    begin
      bubble_shadow_color:='$'+IntToHex(Blue(my_tcolor_color), 2)+IntToHex(Green(my_tcolor_color), 2)+IntToHex(Red(my_tcolor_color), 2);
      jPSColor.CustomColor := ARGBtoCustomColor(my_RGBA_color);
      jPSColor.BackgroundColor := colbrCustom;
      MainModule.jtvBubbleLayouting(nil, true);
    end;

    if whatpaint='bubble_background_color' then
    begin
      bubble_background_color:='$'+IntToHex(Blue(my_tcolor_color), 2)+IntToHex(Green(my_tcolor_color), 2)+IntToHex(Red(my_tcolor_color), 2);
      jPBColor.CustomColor := ARGBtoCustomColor(my_RGBA_color);
      jPBColor.BackgroundColor := colbrCustom;
    end;
    //MainModule.savepreferences;
    jDrawingView_ColorPick.Visible:=false;
    jtvDrawInfo.Visible:=false;
    jbPreview.Visible:=true;
    MainModule.updateinterface;
    MainModule.bubblerefresh;
  end;
end;

procedure TAndroidModule4.jGridView1ClickItem(Sender: TObject;
  ItemIndex: integer; itemCaption: string);
begin
  if ItemIndex<gridcolorcount then
  begin
    if whatpaint='bubble_font_color' then
    begin
      bubble_font_color:=inttostr(ItemIndex);
      jPFColor.BackgroundColor := TARGBColorBridge(ItemIndex);
    end;
    if whatpaint='bubble_shadow_color' then
    begin
      bubble_shadow_color:=inttostr(ItemIndex);
      jPSColor.BackgroundColor :=  TARGBColorBridge(ItemIndex);
      //Shadow text bubble
      MainModule.jtvBubbleLayouting(nil, true);
    end;
    if whatpaint='bubble_background_color' then
    begin
      bubble_background_color:=inttostr(ItemIndex);
      jPBColor.BackgroundColor := TARGBColorBridge(ItemIndex);
    end;
    jGridView1.Visible:=false;
    jtvDrawInfo.Visible:=false;
    jbPreview.Visible:=true;
    MainModule.updateinterface;
    MainModule.bubblerefresh;
  end
  else
  begin
    MainModule.jBitmap_ColorPick.LoadFromAssets('color_pick.png');
    jGridView1.Visible:=false;
    jtvDrawInfo.Visible:=true;
    jDrawingView_ColorPick.Visible:=true;
  end;
end;

procedure TAndroidModule4.jGridView1DrawItemBitmap(Sender: TObject;
  itemIndex: integer; itemCaption: string; out bimap: JObject);
begin
  jBitmap1.CreateBitmap(100,100,TARGBColorBridge(itemIndex));
  if itemindex>=gridcolorcount then
    jBitmap1.DrawText('...',40,50,16,colbrBlack);
  bimap:= jBitmap1.GetImage();
end;

procedure TAndroidModule4.jPBColorClick(Sender: TObject);
begin
  whatpaint:='bubble_background_color';
  jGridView1.Visible:=true;
  jtvDrawInfo.Visible:=true;
  jbPreview.Visible:=false;
  jtvDrawInfo.Text:='Seleccione el color de fondo';
  fillgridcolors;
end;

procedure TAndroidModule4.jPSColorClick(Sender: TObject);
begin
  whatpaint:='bubble_shadow_color';
  jGridView1.Visible:=true;
  jtvDrawInfo.Visible:=true;
  jbPreview.Visible:=false;
  jtvDrawInfo.Text:='Seleccione el color de sombra';
  fillgridcolors;
end;

procedure TAndroidModule4.jPFColorClick(Sender: TObject);
begin
  whatpaint:='bubble_font_color';
  jGridView1.Visible:=true;
  jtvDrawInfo.Visible:=true;
  jbPreview.Visible:=false;
  jtvDrawInfo.Text:='Seleccione el color de texto';
  fillgridcolors;
end;

procedure TAndroidModule4.jsbFontSizeProgressChanged(Sender: TObject;
  progress: integer; fromUser: boolean);
begin
  if jsbFontSize.Progress>0 then
  begin
    MainModule.jtvBubble.FontSize:=Round(jsbFontSize.Progress div 4);
    jtvFontSize.Text:='Tamaño de la fuente ('+inttostr(MainModule.jtvBubble.FontSize)+')';
  end
  else
    jtvFontSize.Text:='Tamaño de la fuente (Por defecto)';
end;

procedure TAndroidModule4.jsbTransparentProgressChanged(Sender: TObject;
  progress: integer; fromUser: boolean);
begin
  MainModule.jpBubble.SetBackgroundAlpha(Round(jsbTransparent.Progress*2.5));
  jtvTransparent.Text:='Opacidad ('+inttostr(jsbTransparent.Progress)+'%)';
end;

end.
