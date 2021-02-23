{Hint: save all files to location: D:\lamw\projects\databubble\jni }
unit unit1;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, scoordinatorlayout, sax_html, dom_html, dom,
  {extendedhtmlparser}
  sappbarlayout, stablayout, stoolbar, sviewpager, Laz_And_Controls,
  windowmanager, preferences, intentmanager, notificationmanager, unit2, unit3,
  unit4, unit5, unit6, unit7, unit8, unit9, unit10, unit11, unit12, unit13,
  unit14, unit15, unit16, unit17, math, dateutils,
  FPimage, FPReadPNG, Graphics, And_jni, snavigationview, sdrawerlayout,
  ctoytimerservice, And_jni_Bridge, ussdservice, broadcastreceiver,
  sfloatingbutton, activitylauncher, telephonymanager;
  
type

  { TMainModule }

  TMainModule = class(jForm)
    jActivityLauncher1: jActivityLauncher;
    jBitmap_ColorPick: jBitmap;
    jBroadcastReceiver1: jBroadcastReceiver;
    jcToyTimerService1: jcToyTimerService;
    jHttpClient1: jHttpClient;
    jimgTrash: jImageView;
    jIntentManager1: jIntentManager;
    jNotificationManager1: jNotificationManager;
    jPBubble: jPanel;
    jPreferences1: jPreferences;
    jPTrash: jPanel;
    jsAppBarLayout1: jsAppBarLayout;
    jsCoordinatorLayout1: jsCoordinatorLayout;
    jsDrawerLayout1: jsDrawerLayout;
    jsFloatingButton1: jsFloatingButton;
    jsNavigationView1: jsNavigationView;
    jsTabLayout1: jsTabLayout;
    jsToolbar1: jsToolbar;
    jsViewPager1: jsViewPager;
    jsViewPager2: jsViewPager;
    jTelephonyManager1: jTelephonyManager;
    jTemporizador: jTimer;
    jTimerConnection: jTimer;
    jTimerTrash: jTimer;
    jtvBubble: jTextView;
    jUSSDService1: jUSSDService;
    jwmBubble: jWindowManager;
    jwmTrash: jWindowManager;
    //procedure jAsyncTaskGetDoInBackground(Sender: TObject; progress: integer;
      //out keepInBackground: boolean);
    //procedure jAsyncTaskGetPostExecute(Sender: TObject; progress: integer);
    //procedure jAsyncTaskGetPreExecute(Sender: TObject; out
      //startProgress: integer);
    //procedure jAsyncTaskGetProgressUpdate(Sender: TObject; progress: integer;
      //out progressUpdate: integer);
    //procedure jAsyncTaskLoginDoInBackground(Sender: TObject; progress: integer;
      //out keepInBackground: boolean);
    //procedure jAsyncTaskLoginPostExecute(Sender: TObject; progress: integer);
    //procedure jAsyncTaskLoginPreExecute(Sender: TObject; out
      //startProgress: integer);
    //procedure jAsyncTaskLoginProgressUpdate(Sender: TObject; progress: integer;
      //out progressUpdate: integer);
    procedure jBroadcastReceiver1Receiver(Sender: TObject; intent: jObject);
    procedure jcToyTimerService1PullElapsedTime(Sender: TObject;
      elapsedTime: int64);
    procedure jHttpClient1CodeResult(Sender: TObject; code: integer);
    procedure jHttpClient1ContentResult(Sender: TObject; content: RawByteString
      );
    procedure jPBubbleClick(Sender: TObject);
    procedure jPBubbleDown(Sender: TObject);
    procedure jPBubbleLongClick(Sender: TObject);
    procedure jPTrashDown(Sender: TObject);
    procedure jsFloatingButton1Click(Sender: TObject);
    procedure jsNavigationView1ClickItem(Sender: TObject; itemId: integer;
      itemCaption: string);
    procedure jTemporizadorTimer(Sender: TObject);
    procedure jTimerConnectionTimer(Sender: TObject);
    procedure jTimerTrashTimer(Sender: TObject);
    procedure jtvBubbleLayouting(Sender: TObject; changed: boolean);
    procedure MainModuleActivityCreate(Sender: TObject; intentData: jObject);
    procedure MainModuleActivityPause(Sender: TObject);
    procedure MainModuleActivityResult(Sender: TObject; requestCode: integer;
      resultCode: TAndroidResult; intentData: jObject);
    procedure MainModuleActivityStart(Sender: TObject);
    procedure MainModuleActivityStop(Sender: TObject);
    procedure MainModuleBackButton(Sender: TObject);
    procedure MainModuleClose(Sender: TObject);
    procedure MainModuleCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure MainModuleDestroy(Sender: TObject);
    procedure MainModuleInit(Sender: TObject);
    procedure MainModuleJNIPrompt(Sender: TObject);
    procedure jsToolbar1ClickNavigationIcon(Sender: TObject);
    procedure flotar;
    procedure parsehtmldata(data:string);
    //procedure parsetemplate(data:string);
    //function fphttpget(url:string):boolean;
    procedure micubacellogin(user:string;pass:string);
    procedure savepreferences;
    procedure loadpreferences;
    procedure showtrash;
    procedure hiddetrash;
    function datadaily(lastdata:string;data:string):string;
    function moneydaily(lastdata:string;data:string):string;
    procedure bubblerefresh;
    procedure bubblestart;
    procedure updateinterface;
    procedure activityupdate;
    procedure jphonecall(numcode:string);
    procedure scancode;
    function havedata(data:string):boolean;
    function strtocolor(clr:string): TColorRGBA;
    function bytestostring(size:float;const Digits: TRoundToRange = -2):string;
    function speedtostring(size:float;const Digits: TRoundToRange = -2):string;
    procedure gettraffic;
  private
    {private declarations}
    function ARGBtoCustomColor(conv_clr: TColorRGBA): DWORD;

  public
    {public declarations}
    //DHTTPClient:THTTPSend;
  end;

const
  info='Nota: Para que esta aplicación funcione adecuadamente:'+#10#10+'1- No la quite de las apps usadas recientemente.'+#10+'2- Permita el uso de datos en segundo plano.'+#10+'3- Permita con ahorro de datos activo.'+#10+'4- Quite la optimización de batería.'+#10#10+'Esta aplicación solo funciona con datos móviles ya que obtiene la información del portal https://mi.cubacel.net  el cual es completamente GRATIS y no resta de sus megas.';
  _color_pick_fn: string = 'color_pick2017.png';
  csbolsadiaria='BD: ';
  csbolsanauta='CO: ';
  csbonolte='BL: ';
  cssololte='SL: ';
  cstodas='3G: ';
  csnacionales='CU: ';
  csbonificados='DB: ';
  cstime='Hr: ';
  cssaldo='$: ';
  csdeuda='-$: ';
  csbonosaldo='$B: ';
  csbonovoz='Voz: ';
  csbonosms='SMS: ';
  csbreakline=' '+#10;

  cebolsadiaria= UTF8String(#$E2#$8F#$B2#$EF#$B8#$8F+' ');
  cebolsanauta= UTF8String(#$F0#$9F#$93#$A7+' ');
  cebonolte= UTF8String(#$F0#$9F#$85#$B1+' ');
  cesololte= UTF8String(#$34#$E2#$83#$A3+' ');
  cetodas= UTF8String(#$F0#$9F#$8C#$8E+' ');
  cenacionales= UTF8String(#$f0#$9f#$87#$a8#$f0#$9f#$87#$ba+' ');
  cebonificados= UTF8String(#$F0#$9F#$93#$A6+' ');
  cetime= UTF8String(#$E2#$8F#$B1#$EF#$B8#$8F+' ');
  cesaldo= UTF8String(#$F0#$9F#$92#$B0+' ');
  cedeuda = UTF8String(#$F0#$9F#$98#$AC+' ');
  cebonosaldo= UTF8String(#$F0#$9F#$92#$B8+' ');
  cebonovoz= UTF8String(#$E2#$98#$8E#$EF#$B8#$8F+' ');
  cebonosms= UTF8String(#$F0#$9F#$92#$AC+' ');
  cebreakline=' '+#10;

  ip='https://152.206.129.20/primary/_-ijqJlSHh';
  ippostpaid='https://152.206.129.20/primary/_-iF0OXHaT0I';
  dominio='https://mi.cubacel.net/primary/_-ijqJlSHh';
  dominiopostpaid='https://mi.cubacel.net/primary/_-iF0OXHaT0I';

var
  MainModule: TMainModule;
  dnacionales,dnavegacion,dbonificados,dlte,dbolsacorreo,dsololte,dtodas,dbolsadiaria,numero,saldo,bonosaldo,expiresaldo,expbonosaldo,expbonodatos,expnacionales,expbolsacorreo,expbolsadiaria,deuda,bubbletext,traffictext:string;
  dailyslte,dailyblte,dailynac,dailyboni,dailymail,dailydaily,dailytodas,dailysaldo,dailybonosaldo:string;
  enacionales,enavegacion,ebonificados,elte,ebolsacorreo,esololte,etodas,ebolsadiaria,esaldo,ebonosaldo,stime:string;
  focused:boolean;
  flotando:boolean=false;
  manualremove:boolean=false;
  manualabort:boolean=false;
  htmlcontent:string;
  rawcontent,tmprawcontent:string;
  login:boolean=false;
  tokenlocation,errormessage:string;
  cnum:integer;
  pX,pY,Tx,Ty,lx,ly:integer;
  movecount:integer;
  strash:boolean=false;
  lastdatetime,lastdateupdate:TDateTime;
  lastdataslte,lastdatablte,lastdatanac,lastdataboni,lastdatamail,lastdatadaily,lastdatatodas,lastdatasaldo,lastdatabonosaldo:string;
  typeshow:integer;
  init_images,colorizeinterface:boolean;
  Img: TFPCustomImage;
  Reader: TFPCustomImageReader;
  whatpaint:string;
  bubble_font_color:string;
  bubble_background_color:string;
  bubble_shadow_color:string;
  ifbold:boolean;
  minimizeonlogin:boolean=false;
  digitos:TRoundToRange;
  encodeuser,encodepass,startData:string;
  retry,badcredentials,logindelay:boolean;
  retrycount:integer;
  lastactivity:string;
  Tinterval:integer=15;
  ussdserviceenable:boolean;
  autostart:boolean=true;
  lasttraffictime:int64;
  lastRxBytes,lastTxBytes:int64;
  hiddeol,showtraffic:boolean;
  ncheck:integer=0;
  postpaid:boolean;
  s:string;
  ifservicerunning:boolean;
  {jPreferences1.SetIntData('digitos',AndroidModule3.jspFormat.SelectedIndex);
  jPreferences1.SetIntData('transparent',AndroidModule4.jsbTransparent.Progress);
  jPreferences1.SetIntData('fontsize',AndroidModule4.jsbFontSize.Progress);
  jPreferences1.SetBoolData('logged',login);
  jPreferences1.SetBoolData('showbolsadiaria',AndroidModule3.jchbBolsaDiaria.Checked);
  jPreferences1.SetBoolData('showbolsanauta',AndroidModule3.jchbBolsaNauta.Checked);
  jPreferences1.SetBoolData('showbonolte',AndroidModule3.jchbBonoLTE.Checked);
  jPreferences1.SetBoolData('showsololte',AndroidModule3.jchbSoloLTE.Checked);
  jPreferences1.SetBoolData('showallnetoworks',AndroidModule3.jchbAllNetworks.Checked);
  jPreferences1.SetBoolData('showinternet',AndroidModule3.jchbNacionales.Checked);
  jPreferences1.SetBoolData('showbonificados',AndroidModule3.jchbBonificados.Checked);
  jPreferences1.SetBoolData('showtime',AndroidModule3.jchbTime.Checked);
  jPreferences1.SetBoolData('showsaldo',AndroidModule3.jchbSaldo.Checked);
  jPreferences1.SetBoolData('showbonosaldo',AndroidModule3.jchbBonoSaldo.Checked);
  jPreferences1.SetBoolData('showdeuda',AndroidModule3.jchbDeuda.Checked);
  jPreferences1.SetBoolData('colorizeinterface',AndroidModule4.jchbColorInterface.Checked);
  jPreferences1.SetStringData('backgroud-color',bubble_background_color);
  jPreferences1.SetStringData('font-color',bubble_font_color);
  jPreferences1.SetStringData('shadow-color',bubble_shadow_color);
  jPreferences1.SetBoolData('bold',AndroidModule4.jchbBold.Checked);
  jPreferences1.SetBoolData('shadow',AndroidModule4.jchbShadow.Checked);
  jPreferences1.SetBoolData('autostart',AndroidModule3.jchbAutoStart.Checked);
  jPreferences1.SetBoolData('notification',AndroidModule3.jchbNotification.Checked);
  jPreferences1.SetBoolData('emoticons',AndroidModule4.jchbEmoticons.Checked);
  jPreferences1.SetBoolData('onlywithdata',AndroidModule3.jchbOnlywData.Checked);
  jPreferences1.SetBoolData('hiddeol',AndroidModule4.jchbHiddeOL.Checked);
  jPreferences1.SetBoolData('service',AndroidModule3.jchbService.Checked);

  jPreferences1.SetStringData('lastdatetime',datetimetostr(lastdatetime));
  jPreferences1.SetStringData('lastdataslte',lastdataslte);
  jPreferences1.SetStringData('lastdatablte',lastdatablte);
  jPreferences1.SetStringData('lastdatatodas',lastdatatodas);
  jPreferences1.SetStringData('lastdatanac',lastdatanac);
  jPreferences1.SetStringData('lastdataboni',lastdataboni);
  jPreferences1.SetStringData('lastdatamail',lastdatamail);
  jPreferences1.SetStringData('lastdatadaily',lastdatadaily);
  jPreferences1.SetStringData('lastdatasaldo',lastdatasaldo);
  jPreferences1.SetStringData('lastdatabonosaldo',lastdatabonosaldo);

  jPreferences1.SetStringData('lastactitvity',lastactivity);

  pX:= jwmBubble.GetViewPositionX();
  pY:= jwmBubble.GetViewPositionY();

  jPreferences1.SetIntData('X', pX);
  jPreferences1.SetIntData('Y', pY);

  jPreferences1.SetIntData('typeshow', typeshow);}

implementation
  
{$R *.lfm}
  

{ TMainModule }

procedure TMainModule.gettraffic;
var
  currentRxBytes,currentTxBytes,totalRxBytes,totalTxBytes:int64;
  currenttime,elapsetime:int64;
  speeddown,speedup:double;
  prettyrx,prettytx:string;
begin
  currentRxBytes:=MainModule.jTelephonyManager1.GetTotalRxBytes();
  currentTxBytes:=MainModule.jTelephonyManager1.GetTotalTxBytes();
  currenttime:=self.GetTimeInMilliseconds;

  totalRxBytes:=currentRxBytes-lastRxBytes;
  totalTxBytes:=currentTxBytes-lastTxBytes;
  elapsetime:=currenttime-lasttraffictime;

  speeddown:=totalRxBytes*1000 / elapsetime;
  speedup:=totalTxBytes*1000 / elapsetime;

  prettyrx:=speedtostring(speeddown,digitos);
  prettytx:=speedtostring(speedup,digitos);

  traffictext:='↑'+prettytx+' ↓'+prettyrx+' ';

  if flotando then
  begin
    if showtraffic then
    begin
      if bubbletext<>'' then
        MainModule.jtvBubble.Text:=bubbletext+#10+traffictext
      else
        MainModule.jtvBubble.Text:=traffictext;
    end
    else
      MainModule.jtvBubble.Text:=bubbletext;
  end;
  if AndroidModule3.jchbNotification.Checked then
  begin
    jNotificationManager1.SetContentIntent(gapp.PackageName, 'App', 'MyCustomDataName','bubble-start');
    jNotificationManager1.SetPriority(npMin);
    jNotificationManager1.AutoCancel:=false;
    jNotificationManager1.Id:=2020;
    if AndroidModule3.jchbTime.Checked=false then
    begin
      if timetostr(lastdateupdate)<>'00:00:00' then
        jNotificationManager1.SetSubject(stime+timetostr(lastdateupdate))
      else
        jNotificationManager1.SetSubject(traffictext);
    end;
    jNotificationManager1.SetTitle(bubbletext);
    //if showtraffic then
      //jNotificationManager1.SetBody(traffictext);
    jNotificationManager1.Notify();
  end;

  //jIntentManager1.SetAction(gApp.AppName+'.LAMW_SMS_WIDGET_NOTIFY');
  //if bubbletext<>'' then
  //  jIntentManager1.PutExtraString('notify_message',bubbletext+#10+traffictext)
  //else
  //  jIntentManager1.PutExtraString('notify_message',traffictext);
  //jIntentManager1.SendBroadcast();

  lastRxBytes:=MainModule.jTelephonyManager1.GetTotalRxBytes();
  lastTxBytes:=MainModule.jTelephonyManager1.GetTotalTxBytes();
  lasttraffictime:=self.GetTimeInMilliseconds;
end;

procedure TMainModule.scancode;
  var
  aIntent:jObject;
begin
  jIntentManager1.SetClass('com.google.zxing.client.android', 'CaptureActivity');
  jIntentManager1.SetAction('com.google.zxing.client.android.SCAN');
  jIntentManager1.PutExtraString('PROMPT_MESSAGE', 'Scanning for machine barcode');
  jIntentManager1.PutExtraString('SAVE_HISTORY', 'false');
  aIntent:=jIntentManager1.GetIntent();
  jActivityLauncher1.StartActivityForResult(aIntent, 1987);
end;

procedure TMainModule.jphonecall(numcode:string);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    //*****jIntentManager method:
    {jIntentManager1.SetAction('android.intent.action.CALL');
    jIntentManager1.SetDataUriAsString('tel:' + numcode);
    if jIntentManager1.ResolveActivity then
      jIntentManager1.StartActivity('Dial USSD Code...')
    else
      ShowMessage('Sorry, Unable to find an App to perform CALL action......');}

    //******jTelephonyManager method:
    jTelePhonyManager1.Call(numcode);
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);
end;

procedure TMainModule.activityupdate;
begin
  if lastactivity='micubacel' then
  begin
    jsViewPager1.Visible:=true;
    jsViewPager2.Visible:=false;
    jsTabLayout1.SetupWithViewPager(jsViewPager1.View);
    jsFloatingButton1.SetImageIdentifier('ic_ussd_white');
    //jsTabLayout1.SetIcon(0,'ic_help');
  end;
  if lastactivity='ussd' then
  begin
    jsViewPager1.Visible:=false;
    jsViewPager2.Visible:=true;
    jsTabLayout1.SetupWithViewPager(jsViewPager2.View);
    jsFloatingButton1.SetImageIdentifier('ic_cubacel_white');
    jsTabLayout1.SetIcon(6,'ic_account_multiple');
    jsTabLayout1.SetIcon(5,'ic_comment_plus');
    jsTabLayout1.SetIcon(4,'ic_phone_plus');
    jsTabLayout1.SetIcon(3,'ic_signal_4g');
    jsTabLayout1.SetIcon(2,'ic_signal_3g');
    jsTabLayout1.SetIcon(1,'ic_cash_usd');
    jsTabLayout1.SetIcon(0,'ic_language_csharp');
  end;
  //jsFloatingButton1.ShowSnackbar(lastactivity);
end;

procedure TMainModule.updateinterface;
var
  f,b:integer;
begin
  if colorizeinterface then
  begin
    if Pos('$',bubble_font_color)>0 then
    begin
      MainModule.jsToolbar1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      MainModule.jsToolbar1.FontColor:=colbrCustom;
      MainModule.jsTabLayout1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      MainModule.jsTabLayout1.SetTabTextColors(colbrCustom,colbrCustom);
      AndroidModule2.jbLogin.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule2.jbLogin.FontColor:=colbrCustom;
      AndroidModule2.jbRegister.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule2.jbRegister.FontColor:=colbrCustom;
      AndroidModule4.jbPreview.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule4.jbPreview.FontColor:=colbrCustom;
      AndroidModule5.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule5.jTextView1.FontColor:=colbrCustom;
      AndroidModule5.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule5.jTextView2.FontColor:=colbrCustom;
      AndroidModule5.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule5.jTextView3.FontColor:=colbrCustom;
      AndroidModule6.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule6.jTextView1.FontColor:=colbrCustom;
      AndroidModule6.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule6.jTextView2.FontColor:=colbrCustom;
      AndroidModule6.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule6.jTextView3.FontColor:=colbrCustom;
      AndroidModule7.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule7.jTextView1.FontColor:=colbrCustom;
      AndroidModule7.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule7.jTextView2.FontColor:=colbrCustom;
      AndroidModule7.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule7.jTextView3.FontColor:=colbrCustom;
      AndroidModule8.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule8.jTextView1.FontColor:=colbrCustom;
      AndroidModule8.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule8.jTextView2.FontColor:=colbrCustom;
      AndroidModule8.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule8.jTextView3.FontColor:=colbrCustom;
      AndroidModule9.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule9.jTextView1.FontColor:=colbrCustom;
      AndroidModule9.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule9.jTextView2.FontColor:=colbrCustom;
      AndroidModule9.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule9.jTextView3.FontColor:=colbrCustom;
      AndroidModule10.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule10.jTextView1.FontColor:=colbrCustom;
      AndroidModule10.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule10.jTextView2.FontColor:=colbrCustom;
      AndroidModule10.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule10.jTextView3.FontColor:=colbrCustom;
      AndroidModule11.jTextView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule11.jTextView1.FontColor:=colbrCustom;
      AndroidModule11.jTextView2.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule11.jTextView2.FontColor:=colbrCustom;
      AndroidModule11.jTextView3.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      AndroidModule11.jTextView3.FontColor:=colbrCustom;
      TranferModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      TranferModule.jbOK.FontColor:=colbrCustom;
      TranferModule.jbContact.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      TranferModule.jbContact.FontColor:=colbrCustom;
      RechargModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      RechargModule.jbOK.FontColor:=colbrCustom;
      RechargModule.jbScan.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      RechargModule.jbScan.FontColor:=colbrCustom;
      {OldRechargModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      OldRechargModule.jbOK.FontColor:=colbrCustom;
      OldRechargModule.jbScan.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      OldRechargModule.jbScan.FontColor:=colbrCustom;}
      CallModule.jbCallAnon.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      CallModule.jbCallAnon.FontColor:=colbrCustom;
      CallModule.jbCall99.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      CallModule.jbCall99.FontColor:=colbrCustom;
      CallModule.jbContact.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      CallModule.jbContact.FontColor:=colbrCustom;
      FriendModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      FriendModule.jbOK.FontColor:=colbrCustom;
      FriendModule.jbContact.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      FriendModule.jbContact.FontColor:=colbrCustom;
    end
    else
    begin
      trystrtoint(bubble_font_color,f);
      MainModule.jsToolbar1.FontColor:=TARGBColorBridge(f);
      MainModule.jsTabLayout1.SetTabTextColors(TARGBColorBridge(f),TARGBColorBridge(f));
      AndroidModule2.jbLogin.FontColor:=TARGBColorBridge(f);
      AndroidModule2.jbRegister.FontColor:=TARGBColorBridge(f);
      AndroidModule4.jbPreview.FontColor:=TARGBColorBridge(f);
      AndroidModule5.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule5.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule5.jTextView3.FontColor:=TARGBColorBridge(f);
      AndroidModule6.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule6.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule6.jTextView3.FontColor:=TARGBColorBridge(f);
      AndroidModule7.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule7.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule7.jTextView3.FontColor:=TARGBColorBridge(f);
      AndroidModule8.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule8.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule8.jTextView3.FontColor:=TARGBColorBridge(f);
      AndroidModule9.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule9.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule9.jTextView3.FontColor:=TARGBColorBridge(f);
      AndroidModule10.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule10.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule10.jTextView3.FontColor:=TARGBColorBridge(f);
      AndroidModule11.jTextView1.FontColor:=TARGBColorBridge(f);
      AndroidModule11.jTextView2.FontColor:=TARGBColorBridge(f);
      AndroidModule11.jTextView3.FontColor:=TARGBColorBridge(f);
      TranferModule.jbOK.FontColor:=TARGBColorBridge(f);
      TranferModule.jbContact.FontColor:=TARGBColorBridge(f);
      RechargModule.jbOK.FontColor:=TARGBColorBridge(f);
      RechargModule.jbScan.FontColor:=TARGBColorBridge(f);
      //OldRechargModule.jbOK.FontColor:=TARGBColorBridge(f);
      //OldRechargModule.jbScan.FontColor:=TARGBColorBridge(f);
      CallModule.jbCallAnon.FontColor:=TARGBColorBridge(f);
      CallModule.jbCall99.FontColor:=TARGBColorBridge(f);
      CallModule.jbContact.FontColor:=TARGBColorBridge(f);
      FriendModule.jbOK.FontColor:=TARGBColorBridge(f);
      FriendModule.jbContact.FontColor:=TARGBColorBridge(f);
    end;
    if Pos('$',bubble_background_color)>0 then
    begin
      MainModule.jsToolbar1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_background_color));
      MainModule.jsToolbar1.BackgroundColor:=colbrCustom;
      MainModule.jsTabLayout1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_background_color));
      MainModule.jsTabLayout1.BackgroundColor:=colbrCustom;
      AndroidModule2.jbLogin.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule2.jbLogin.BackgroundColor:=colbrCustom;
      AndroidModule2.jbRegister.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule2.jbRegister.BackgroundColor:=colbrCustom;
      AndroidModule4.jbPreview.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule4.jbPreview.BackgroundColor:=colbrCustom;
      AndroidModule5.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule5.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule5.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule5.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      AndroidModule6.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule6.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule6.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule6.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      AndroidModule7.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule7.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule7.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule7.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      AndroidModule8.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule8.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule8.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule8.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      AndroidModule9.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule9.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule9.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule9.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      AndroidModule10.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule10.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule10.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule10.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      AndroidModule11.jPanel1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule11.jPanel1.BackgroundColor:=colbrCustom;
      AndroidModule11.jsRecyclerView1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      AndroidModule11.jsRecyclerView1.SetCardBackgroundColor(colbrCustom);
      TranferModule.jbContact.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      TranferModule.jbContact.BackgroundColor:=colbrCustom;
      TranferModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      TranferModule.jbOK.BackgroundColor:=colbrCustom;
      RechargModule.jbScan.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      RechargModule.jbScan.BackgroundColor:=colbrCustom;
      RechargModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      RechargModule.jbOK.BackgroundColor:=colbrCustom;
      {OldRechargModule.jbScan.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      OldRechargModule.jbScan.BackgroundColor:=colbrCustom;
      OldRechargModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      OldRechargModule.jbOK.BackgroundColor:=colbrCustom;}
      CallModule.jbContact.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      CallModule.jbContact.BackgroundColor:=colbrCustom;
      CallModule.jbCallAnon.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      CallModule.jbCallAnon.BackgroundColor:=colbrCustom;
      CallModule.jbCall99.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      CallModule.jbCall99.BackgroundColor:=colbrCustom;
      FriendModule.jbContact.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      FriendModule.jbContact.BackgroundColor:=colbrCustom;
      FriendModule.jbOK.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      FriendModule.jbOK.BackgroundColor:=colbrCustom;
      jsFloatingButton1.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_Background_color));
      jsFloatingButton1.BackgroundColor:=colbrCustom;
    end
    else
    begin
      trystrtoint(bubble_background_color,b);
      MainModule.jsToolbar1.BackgroundColor:=TARGBColorBridge(b);
      MainModule.jsTabLayout1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule2.jbLogin.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule2.jbRegister.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule4.jbPreview.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule5.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule5.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      AndroidModule6.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule6.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      AndroidModule7.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule7.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      AndroidModule8.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule8.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      AndroidModule9.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule9.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      AndroidModule10.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule10.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      AndroidModule11.jPanel1.BackgroundColor:=TARGBColorBridge(b);
      AndroidModule11.jsRecyclerView1.SetCardBackgroundColor(TARGBColorBridge(b));
      TranferModule.jbContact.BackgroundColor:=TARGBColorBridge(b);
      TranferModule.jbOK.BackgroundColor:=TARGBColorBridge(b);
      RechargModule.jbScan.BackgroundColor:=TARGBColorBridge(b);
      RechargModule.jbOK.BackgroundColor:=TARGBColorBridge(b);
      //OldRechargModule.jbScan.BackgroundColor:=TARGBColorBridge(b);
      //OldRechargModule.jbOK.BackgroundColor:=TARGBColorBridge(b);
      CallModule.jbContact.BackgroundColor:=TARGBColorBridge(b);
      CallModule.jbCallAnon.BackgroundColor:=TARGBColorBridge(b);
      CallModule.jbCall99.BackgroundColor:=TARGBColorBridge(b);
      FriendModule.jbContact.BackgroundColor:=TARGBColorBridge(b);
      FriendModule.jbOK.BackgroundColor:=TARGBColorBridge(b);
      jsFloatingButton1.BackgroundColor:=TARGBColorBridge(b);
    end;
  end
  else
  begin
    MainModule.jsToolbar1.FontColor:=colbrWhite;
    MainModule.jsTabLayout1.SetTabTextColors(colbrWhite,colbrWhite);
    MainModule.jsToolbar1.SetBackgroundToPrimaryColor();
    MainModule.jsTabLayout1.SetBackgroundToPrimaryColor();
    AndroidModule2.jbLogin.BackgroundColor:=colBrRoyalBlue;
    AndroidModule2.jbRegister.BackgroundColor:=colBrRoyalBlue;
    AndroidModule4.jbPreview.BackgroundColor:=colBrRoyalBlue;
    AndroidModule2.jbLogin.FontColor:=colbrWhite;
    AndroidModule2.jbRegister.FontColor:=colbrWhite;
    AndroidModule4.jbPreview.FontColor:=colbrWhite;
    AndroidModule5.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule5.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule5.jTextView1.FontColor:=colbrWhite;
    AndroidModule5.jTextView2.FontColor:=colbrWhite;
    AndroidModule5.jTextView3.FontColor:=colbrWhite;
    AndroidModule6.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule6.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule6.jTextView1.FontColor:=colbrWhite;
    AndroidModule6.jTextView2.FontColor:=colbrWhite;
    AndroidModule6.jTextView3.FontColor:=colbrWhite;
    AndroidModule7.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule7.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule7.jTextView1.FontColor:=colbrWhite;
    AndroidModule7.jTextView2.FontColor:=colbrWhite;
    AndroidModule7.jTextView3.FontColor:=colbrWhite;
    AndroidModule8.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule8.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule8.jTextView1.FontColor:=colbrWhite;
    AndroidModule8.jTextView2.FontColor:=colbrWhite;
    AndroidModule8.jTextView3.FontColor:=colbrWhite;
    AndroidModule9.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule9.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule9.jTextView1.FontColor:=colbrWhite;
    AndroidModule9.jTextView2.FontColor:=colbrWhite;
    AndroidModule9.jTextView3.FontColor:=colbrWhite;
    AndroidModule10.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule10.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule10.jTextView1.FontColor:=colbrWhite;
    AndroidModule10.jTextView2.FontColor:=colbrWhite;
    AndroidModule10.jTextView3.FontColor:=colbrWhite;
    AndroidModule11.jPanel1.BackgroundColor:=colbrRoyalBlue;
    AndroidModule11.jsRecyclerView1.SetCardBackgroundColor(colbrRoyalBlue);
    AndroidModule11.jTextView1.FontColor:=colbrWhite;
    AndroidModule11.jTextView2.FontColor:=colbrWhite;
    AndroidModule11.jTextView3.FontColor:=colbrWhite;
    TranferModule.jbContact.BackgroundColor:=colbrRoyalBlue;
    TranferModule.jbOK.BackgroundColor:=colbrRoyalBlue;
    TranferModule.jbContact.FontColor:=colbrWhite;
    TranferModule.jbOK.FontColor:=colbrWhite;
    RechargModule.jbScan.BackgroundColor:=colbrRoyalBlue;
    RechargModule.jbOK.BackgroundColor:=colbrRoyalBlue;
    RechargModule.jbScan.FontColor:=colbrWhite;
    RechargModule.jbOK.FontColor:=colbrWhite;
    CallModule.jbContact.BackgroundColor:=colbrRoyalBlue;
    CallModule.jbCallAnon.BackgroundColor:=colbrRoyalBlue;
    CallModule.jbCallAnon.FontColor:=colbrWhite;
    CallModule.jbCall99.BackgroundColor:=colbrRoyalBlue;
    CallModule.jbCall99.FontColor:=colbrWhite;
    CallModule.jbContact.FontColor:=colbrWhite;
    FriendModule.jbContact.BackgroundColor:=colbrRoyalBlue;
    FriendModule.jbOK.BackgroundColor:=colbrRoyalBlue;
    FriendModule.jbContact.FontColor:=colbrWhite;
    FriendModule.jbOK.FontColor:=colbrWhite;
    jsFloatingButton1.BackgroundColor:=colbrRoyalBlue;
  end;
  //if AndroidModule2.jbLogin.Enabled=false then
    //AndroidModule2.jbLogin.FontColor:=colbrGray;
  AndroidModule2.jbLogin.SetRadiusRoundCorner(50);
  AndroidModule2.jbLogin.SetRoundCorner();
  AndroidModule2.jbRegister.SetRadiusRoundCorner(50);
  AndroidModule2.jbRegister.SetRoundCorner();
  AndroidModule4.jbPreview.SetRadiusRoundCorner(50);
  AndroidModule4.jbPreview.SetRoundCorner();
  TranferModule.jbContact.SetFontFromAssets('fa-solid-900.ttf');
  TranferModule.jbContact.Text:=Self.ParseHtmlFontAwesome('&#xf406;');
  TranferModule.jbContact.SetRadiusRoundCorner(50);
  TranferModule.jbContact.SetRoundCorner();
  TranferModule.jbOK.SetRadiusRoundCorner(50);
  TranferModule.jbOK.SetRoundCorner();
  RechargModule.jbScan.SetFontFromAssets('fa-solid-900.ttf');
  RechargModule.jbScan.Text:=Self.ParseHtmlFontAwesome('&#xf029;');
  RechargModule.jbScan.SetRadiusRoundCorner(50);
  RechargModule.jbScan.SetRoundCorner();
  RechargModule.jbOK.SetRadiusRoundCorner(50);
  RechargModule.jbOK.SetRoundCorner();
  CallModule.jbContact.SetFontFromAssets('fa-solid-900.ttf');
  CallModule.jbContact.Text:=Self.ParseHtmlFontAwesome('&#xf406;');
  CallModule.jbContact.SetRadiusRoundCorner(50);
  CallModule.jbContact.SetRoundCorner();
  CallModule.jbCallAnon.SetRadiusRoundCorner(50);
  CallModule.jbCallAnon.SetRoundCorner();
  CallModule.jbCall99.SetRadiusRoundCorner(50);
  CallModule.jbCall99.SetRoundCorner();
  FriendModule.jbContact.SetFontFromAssets('fa-solid-900.ttf');
  FriendModule.jbContact.Text:=Self.ParseHtmlFontAwesome('&#xf406;');
  FriendModule.jbContact.SetRadiusRoundCorner(50);
  FriendModule.jbContact.SetRoundCorner();
  FriendModule.jbOK.SetRadiusRoundCorner(50);
  FriendModule.jbOK.SetRoundCorner();
  AndroidModule5.jsRecyclerView1.Refresh;
  AndroidModule6.jsRecyclerView1.Refresh;
  AndroidModule7.jsRecyclerView1.Refresh;
  AndroidModule8.jsRecyclerView1.Refresh;
  AndroidModule9.jsRecyclerView1.Refresh;
  AndroidModule10.jsRecyclerView1.Refresh;
  AndroidModule11.jsRecyclerView1.Refresh;
  {for i:=0 to AndroidModule5.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule5.jsRecyclerView1.Refresh(i);
  for i:=0 to AndroidModule6.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule6.jsRecyclerView1.Refresh(i);
  for i:=0 to AndroidModule7.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule7.jsRecyclerView1.Refresh(i);
  for i:=0 to AndroidModule8.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule8.jsRecyclerView1.Refresh(i);
  for i:=0 to AndroidModule9.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule9.jsRecyclerView1.Refresh(i);
  for i:=0 to AndroidModule10.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule10.jsRecyclerView1.Refresh(i);
  for i:=0 to AndroidModule11.jsRecyclerView1.GetItemCount()-1 do
    AndroidModule11.jsRecyclerView1.Refresh(i);}
end;

function TMainModule.havedata(data:string):boolean;
begin
  if AndroidModule3.jchbOnlywData.Checked=false then
  begin
    result:=true;
    exit;
  end
  else
  begin
    if  (data<>'') and (data<>'0B') and (data<>'0.00') and (data<>'0.00CUC') and (data<>'0.00CUP') then
      result:=true
    else
      result:=false;
  end;
end;

procedure TMainModule.bubblestart;
begin
  encodeuser:=AndroidModule2.jetUser.Text;
  encodepass:=AndroidModule2.jetPassword.Text;
  if login=false then
  begin
    postpaid:=AndroidModule2.jchbPostpaid.Checked;
    AndroidModule2.jbLogin.Text:='Salir';
    AndroidModule2.jetUser.Enabled:=false;
    AndroidModule2.jetPassword.Enabled:=false;
    manualabort:=false;
    badcredentials:=false;
    bubbletext:='Accediendo...';
    //if (jAsyncTaskLogin.Running=false) and (jAsyncTaskGet.Running=false)then
      //jAsyncTaskLogin.Execute;
      micubacellogin(encodeuser,encodepass);
  end;
  if flotando=false then
    flotar;
end;

procedure TMainModule.bubblerefresh;
var
  f,b:integer;
begin
  if flotando then
  begin
    if AndroidModule4.jchbBold.Checked then
      jtvBubble.TextTypeFace:=tfBold
    else
      jtvBubble.TextTypeFace:=tfNormal;
    if Pos('$',bubble_font_color)>0 then
    begin
      jtvBubble.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_font_color));
      jtvBubble.FontColor:=colbrCustom;
    end
    else
    begin
      trystrtoint(bubble_font_color,f);
      jtvBubble.FontColor:=TARGBColorBridge(f);
    end;
    if Pos('$',bubble_background_color)>0 then
    begin
      jPBubble.CustomColor:=ARGBtoCustomColor(strtocolor(bubble_background_color));
      jPBubble.BackgroundColor:=colbrCustom;
    end
    else
    begin
      trystrtoint(bubble_background_color,b);
      jPBubble.BackgroundColor:=TARGBColorBridge(b);
    end;
    jwmBubble.SetRadiusRoundCorner(10);
    jwmBubble.SetViewRoundCorner();
    jwmBubble.SetViewFocusable(false);
    jpBubble.SetBackgroundAlpha(Round(AndroidModule4.jsbTransparent.Progress*2.5));
  end;
end;

function stringtobytes(data:string):float;
var
  ndata:float=0.000;
  tmpdata:string;
begin
  if data<>'' then
  begin
    if Pos('GB',data)>0 then
    begin
      tmpdata:=StringReplace(data,'GB','',[rfReplaceAll]);
      trystrtofloat(tmpdata,ndata);
      ndata:=ndata*1024*1024*1024;
    end;
    if Pos('MB',data)>0 then
    begin
      tmpdata:=StringReplace(data,'MB','',[rfReplaceAll]);
      trystrtofloat(tmpdata,ndata);
      ndata:=ndata*1024*1024;
    end;
    if Pos('KB',data)>0 then
    begin
      tmpdata:=StringReplace(data,'KB','',[rfReplaceAll]);
      trystrtofloat(tmpdata,ndata);
      ndata:=ndata*1024;
    end;
    if (Pos('B',data)>0) and (Pos('G',data)<=0) and (Pos('M',data)<=0) and (Pos('K',data)<=0) then
    begin
      tmpdata:=StringReplace(data,'B','',[rfReplaceAll]);
      trystrtofloat(tmpdata,ndata);
    end;
    result:=ndata;
  end
   else
     result:=0.000;
end;

function stringtomoney(data:string):float;
var
  ndata:float=0.00;
  tmpdata:string;
begin
  if data<>'' then
  begin
    if Pos('CUC',data)>0 then
    begin
      tmpdata:=StringReplace(data,'CUC','',[rfReplaceAll]);
      trystrtofloat(tmpdata,ndata);
      //ndata:=ndata*1024*1024*1024*1024;
    end;
    if Pos('CUP',data)>0 then
    begin
      tmpdata:=StringReplace(data,'CUP','',[rfReplaceAll]);
      trystrtofloat(tmpdata,ndata);
      //ndata:=ndata*1024*1024*1024;
    end;
    {if (Pos('B',data)>0) and (Pos('G',data)<=0) and (Pos('M',data)<=0) and (Pos('K',data)<=0) then
    begin
      tmpdata:=StringReplace(data,'B','',[rfReplaceAll]);
      ndata:=strtofloat(tmpdata);
    end;}
    if ndata=0.00 then
    begin
      trystrtofloat(data,ndata);
      result:=ndata;
    end
    else
      result:=ndata;
  end
   else
     result:=0.00;
end;

function TMainModule.bytestostring(size:float;const Digits: TRoundToRange = -2):string;
var
  tempstr:string='';
begin

  if(size<1024) then
    tempstr:=floattostr(size)+'B';
  if(size>=1024) then
    tempstr:=floattostr(SimpleRoundTo(size/1024,Digits))+'K';
  if(size>=(1024*1024)) then
    tempstr:=floattostr(SimpleRoundTo(size/1024/1024,Digits))+'M';
  if(size>=(1024*1024*1024)) then
    tempstr:=floattostr(SimpleRoundTo(size/1024/1024/1024,Digits))+'G';
  if(size>=(1024*1024*1024*1024)) then
    tempstr:=floattostr(SimpleRoundTo(size/1024/1024/1024/1024,Digits))+'T';

  result:=tempstr;
end;

function TMainModule.speedtostring(size:float;const Digits: TRoundToRange = -2):string;
var
  tempstr:string='';
  ceros:string='0';
begin
  if(size<1024*1024) then
  begin
    tempstr:=floattostr(SimpleRoundTo(size/1024,Digits))+'K';
  end;
  if(size>=(1024*1024)) then
  begin
    tempstr:=floattostr(SimpleRoundTo(size/1024/1024,Digits))+'M';
  end;
  if(size>=(1024*1024*1024)) then
  begin
    tempstr:=floattostr(SimpleRoundTo(size/1024/1024/1024,Digits))+'G';
  end;
  if digits=0 then
    ceros:='';
  if digits=-1 then
    ceros:='.0';
  if digits=-2 then
    ceros:='.00';
  if digits=-3 then
    ceros:='.000';
  if Pos('.',tempstr)<=0 then
  begin
    tempstr:=StringReplace(tempstr,'K',ceros+'K',[rfReplaceAll]);
    tempstr:=StringReplace(tempstr,'M',ceros+'M',[rfReplaceAll]);
    tempstr:=StringReplace(tempstr,'G',ceros+'G',[rfReplaceAll]);
  end;

  result:=tempstr;
end;

function TMainModule.ARGBtoCustomColor(conv_clr: TColorRGBA): DWORD;
begin
  Result := (conv_clr.A shl 24) + (conv_clr.R shl 16) + (conv_clr.G shl 8) + conv_clr.B;
end;

function TMainModule.strtocolor(clr:string): TColorRGBA;
var
  my_tcolor_color: TColor;
  my_RGBA_color: TColorRGBA;
begin
  if (clr<>'') then
  begin
    my_tcolor_color := StringToColor(clr);
    my_RGBA_color.A := $FF; // not transparent
    my_RGBA_color.R := RED(my_tcolor_color);
    my_RGBA_color.G := GREEN(my_tcolor_color);
    my_RGBA_color.B := BLUE(my_tcolor_color);
    result:=my_RGBA_color;
  end;
end;

function TMainModule.datadaily(lastdata:string;data:string):string;
begin
  result:=bytestostring(stringtobytes(lastdata)-stringtobytes(data),digitos);
end;

function TMainModule.moneydaily(lastdata:string;data:string):string;
begin
  result:=floattostr(SimpleRoundTo(stringtomoney(lastdata)-stringtomoney(data)));
end;

procedure TMainModule.ShowTrash;
begin
  if jwmTrash.CanDrawOverlays() then
  begin
    strash:=true;
    jimgTrash.SetImageFromAssets('trash.png');
    if (Round(GetScreenWidth()/2)-Round(jPTrash.Width/2)> 0) and (GetScreenHeight()-50>0)  then
    begin
      tX:=Round(GetScreenWidth()/2)-Round(jPTrash.Width/2);
      tY:=GetScreenHeight()-50;
      jwmTrash.SetViewPosition(tX,tY);
    end;
    jPTrash.BackgroundColor:=colbrRed;
    jwmTrash.AddView(jPTrash.View);
    jwmTrash.SetRadiusRoundCorner(60);
    jwmTrash.SetViewRoundCorner();
    jwmTrash.SetViewFocusable(false);
    jPTrash.SetBackgroundAlpha(200);
  end;
end;

procedure TMainModule.hiddetrash;
begin
  strash:=false;
  jwmTrash.RemoveView();
end;

procedure TMainModule.savepreferences;
begin
  //ShowMessage('Guardando preferencias...');
  jPreferences1.SetIntData('interval',AndroidModule3.jsbInterval.Progress);
  jPreferences1.SetIntData('digitos',AndroidModule3.jrgFormat.CheckedIndex);
  jPreferences1.SetIntData('transparent',AndroidModule4.jsbTransparent.Progress);
  jPreferences1.SetIntData('fontsize',AndroidModule4.jsbFontSize.Progress);
  jPreferences1.SetBoolData('logged',login);
  jPreferences1.SetBoolData('showbolsadiaria',AndroidModule3.jchbBolsaDiaria.Checked);
  jPreferences1.SetBoolData('showbolsanauta',AndroidModule3.jchbBolsaNauta.Checked);
  jPreferences1.SetBoolData('showbonolte',AndroidModule3.jchbBonoLTE.Checked);
  jPreferences1.SetBoolData('showsololte',AndroidModule3.jchbSoloLTE.Checked);
  jPreferences1.SetBoolData('showallnetoworks',AndroidModule3.jchbAllNetworks.Checked);
  jPreferences1.SetBoolData('showinternet',AndroidModule3.jchbNacionales.Checked);
  jPreferences1.SetBoolData('showbonificados',AndroidModule3.jchbBonificados.Checked);
  jPreferences1.SetBoolData('showupdatetime',AndroidModule3.jchbTime.Checked);
  jPreferences1.SetBoolData('showsaldo',AndroidModule3.jchbSaldo.Checked);
  jPreferences1.SetBoolData('showbonosaldo',AndroidModule3.jchbBonoSaldo.Checked);
  jPreferences1.SetBoolData('showdeuda',AndroidModule3.jchbDeuda.Checked);
  jPreferences1.SetBoolData('showtraffic',showtraffic);
  jPreferences1.SetBoolData('colorizeinterface',AndroidModule4.jchbColorInterface.Checked);
  jPreferences1.SetStringData('backgroud-color',bubble_background_color);
  jPreferences1.SetStringData('font-color',bubble_font_color);
  jPreferences1.SetStringData('shadow-color',bubble_shadow_color);
  jPreferences1.SetBoolData('bold',AndroidModule4.jchbBold.Checked);
  jPreferences1.SetBoolData('shadow',AndroidModule4.jchbShadow.Checked);
  jPreferences1.SetBoolData('autostart',autostart);
  jPreferences1.SetBoolData('notification',AndroidModule3.jchbNotification.Checked);
  jPreferences1.SetBoolData('emoticons',AndroidModule4.jchbEmoticons.Checked);
  jPreferences1.SetBoolData('onlywithdata',AndroidModule3.jchbOnlywData.Checked);
  jPreferences1.SetBoolData('hiddeol',hiddeol);
  jPreferences1.SetBoolData('ussdservice',ussdserviceenable);

  jPreferences1.SetStringData('lastdatetime',datetimetostr(lastdatetime));
  jPreferences1.SetStringData('lastdataslte',lastdataslte);
  jPreferences1.SetStringData('lastdatablte',lastdatablte);
  jPreferences1.SetStringData('lastdatatodas',lastdatatodas);
  jPreferences1.SetStringData('lastdatanac',lastdatanac);
  jPreferences1.SetStringData('lastdataboni',lastdataboni);
  jPreferences1.SetStringData('lastdatamail',lastdatamail);
  jPreferences1.SetStringData('lastdatadaily',lastdatadaily);
  jPreferences1.SetStringData('lastdatasaldo',lastdatasaldo);
  jPreferences1.SetStringData('lastdatabonosaldo',lastdatabonosaldo);

  jPreferences1.SetStringData('lastactitvity',lastactivity);

  pX:= jwmBubble.GetViewPositionX();
  pY:= jwmBubble.GetViewPositionY();

  jPreferences1.SetIntData('X', lX);
  jPreferences1.SetIntData('Y', lY);
end;

procedure TMainModule.loadpreferences;
var
  b,f,s:integer;
begin
  Tinterval:=jPreferences1.GetIntData('interval',15);
  if Tinterval>=5 then
    AndroidModule3.jsbInterval.Progress:=Tinterval
  else
  begin
    Tinterval:=15;
    AndroidModule3.jsbInterval.Progress:=Tinterval;
  end;
  AndroidModule3.jrgFormat.CheckedIndex:=jPreferences1.GetIntData('digitos',1);
  digitos:=0-AndroidModule3.jrgFormat.CheckedIndex;
  AndroidModule4.jsbTransparent.Progress:=jPreferences1.GetIntData('transparent',70);
  AndroidModule4.jsbFontSize.Progress:=jPreferences1.GetIntData('fontsize',48);/// div 4
  AndroidModule2.jetUser.Text:=jPreferences1.GetStringData('user','');
  AndroidModule2.jetPassword.Text:=jPreferences1.GetStringData('pass','');
  //login:=jPreferences1.GetBoolData('logged',false);
  AndroidModule3.jchbBolsaDiaria.Checked:=jPreferences1.GetBoolData('showbolsadiaria',true);
  AndroidModule3.jchbBolsaNauta.Checked:=jPreferences1.GetBoolData('showbolsanauta',true);
  AndroidModule3.jchbBonoLTE.Checked:=jPreferences1.GetBoolData('showbonolte',true);
  AndroidModule3.jchbSoloLTE.Checked:=jPreferences1.GetBoolData('showsololte',true);
  AndroidModule3.jchbAllNetworks.Checked:=jPreferences1.GetBoolData('showallnetoworks',true);
  AndroidModule3.jchbNacionales.Checked:=jPreferences1.GetBoolData('showinternet',true);
  AndroidModule3.jchbBonificados.Checked:=jPreferences1.GetBoolData('showbonificados',true);
  AndroidModule3.jchbTime.Checked:=jPreferences1.GetBoolData('showupdatetime',false);
  AndroidModule3.jchbSaldo.Checked:=jPreferences1.GetBoolData('showsaldo',true);
  AndroidModule3.jchbBonoSaldo.Checked:=jPreferences1.GetBoolData('showbonosaldo',true);
  AndroidModule3.jchbDeuda.Checked:=jPreferences1.GetBoolData('showdeuda',true);
  showtraffic:=jPreferences1.GetBoolData('showtraffic',true);
  AndroidModule3.jchbTraffic.Checked:=showtraffic;
  hiddeol:=jPreferences1.GetBoolData('hiddeol',true);
  AndroidModule4.jchbHiddeOL.Checked:=hiddeol;
  AndroidModule3.jchbService.Checked:=jPreferences1.GetBoolData('service',false);
  ussdserviceenable:=jPreferences1.GetBoolData('ussdservice',false);
  AndroidModule3.jchbServiceUSSD.Checked:=ussdserviceenable;
  colorizeinterface:=jPreferences1.GetBoolData('colorizeinterface',false);
  AndroidModule4.jchbColorInterface.Checked:=colorizeinterface;
  postpaid:=jPreferences1.GetBoolData('postpaid',false);
  AndroidModule2.jchbPostpaid.Checked:=postpaid;
  bubble_background_color:=jPreferences1.GetStringData('backgroud-color','103');//blueRoyal
  bubble_font_color:=jPreferences1.GetStringData('font-color','88');//white
  bubble_shadow_color:=jPreferences1.GetStringData('shadow-color','0');//black
  AndroidModule4.jchbBold.Checked:=jPreferences1.GetBoolData('bold',false);
  AndroidModule4.jchbShadow.Checked:=jPreferences1.GetBoolData('shadow',true);
  if self.GetSystemVersion>=24 then
    AndroidModule4.jchbEmoticons.Checked:=jPreferences1.GetBoolData('emoticons',true)
  else
    AndroidModule4.jchbEmoticons.Checked:=jPreferences1.GetBoolData('emoticons',false);

  AndroidModule3.jchbOnlywData.Checked:=jPreferences1.GetBoolData('onlywithdata',true);
  //////////////////////////////////////////////////////////////////////////
  if Pos('$',bubble_font_color)>0 then
  begin
    AndroidModule4.jPFColor.CustomColor := ARGBtoCustomColor(strtocolor(bubble_font_color));
    AndroidModule4.jPFColor.BackgroundColor := colbrCustom;
  end
  else
  begin
    trystrtoint(bubble_font_color,f);
    AndroidModule4.jPFColor.BackgroundColor := TARGBColorBridge(f);
  end;
  if Pos('$',bubble_background_color)>0 then
  begin
    AndroidModule4.jPBColor.CustomColor := ARGBtoCustomColor(strtocolor(bubble_background_color));
    AndroidModule4.jPBColor.BackgroundColor := colbrCustom;
  end
  else
  begin
    trystrtoint(bubble_background_color,b);
    AndroidModule4.jPBColor.BackgroundColor := TARGBColorBridge(b);
  end;
  if Pos('$',bubble_shadow_color)>0 then
  begin
    AndroidModule4.jPSColor.CustomColor := ARGBtoCustomColor(strtocolor(bubble_shadow_color));
    AndroidModule4.jPSColor.BackgroundColor := colbrCustom;
  end
  else
  begin
    trystrtoint(bubble_shadow_color,s);
    AndroidModule4.jPSColor.BackgroundColor := TARGBColorBridge(s);
  end;
  //////////////////////////////////////////////////////////////////////////
  autostart:=jPreferences1.GetBoolData('autostart',true);
  AndroidModule3.jchbAutoStart.Checked:=autostart;
  AndroidModule3.jchbNotification.Checked:=jPreferences1.GetBoolData('notification',true);
  lX:= jPreferences1.GetIntData('X', -1);  //  -1 = dummy
  lY:= jPreferences1.GetIntData('Y', -1);
  trystrtodatetime(jPreferences1.GetStringData('lastdatetime',datetimetostr(IncDay(now,-1))),lastdatetime);

  lastdataslte:=jPreferences1.GetStringData('lastdataslte','0B');
  lastdatablte:=jPreferences1.GetStringData('lastdatablte','0B');
  lastdatatodas:=jPreferences1.GetStringData('lastdatatodas','0B');
  lastdatanac:=jPreferences1.GetStringData('lastdatanac','0B');
  lastdataboni:=jPreferences1.GetStringData('lastdataboni','0B');
  lastdatamail:=jPreferences1.GetStringData('lastdatamail','0B');
  lastdatadaily:=jPreferences1.GetStringData('lastdatadaily','0B');
  lastdatasaldo:=jPreferences1.GetStringData('lastdatasaldo','0.00');
  lastdatabonosaldo:=jPreferences1.GetStringData('lastdatabonosaldo','0.00');

  lastactivity:=jPreferences1.GetStringData('lastactitvity','micubacel');

  typeshow:=jPreferences1.GetIntData('typeshow',2);
  //cnum:=jPreferences1.GetIntData('cnum',0);
end;

procedure TMainModule.micubacellogin(user:string;pass:string);
var
  cookie:jobject;
begin
  {try
  retry:=false;
  badcredentials:=false;
  if Assigned(DHTTPClient) then
  begin
    login:=false;
    DHTTPClient.Headers.Clear;
    DHTTPClient.Cookies.Clear;
    DHTTPClient.Protocol:='1.1';
    DHTTPClient.MimeType:='application/x-www-form-urlencoded';
    DHTTPClient.KeepAlive:=true;
    DHTTPClient.UserAgent:='Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36';
    DHTTPClient.Document.Position:=0;
    WriteStrToStream(DHTTPClient.Document, AnsiString('language=es_ES&username='+user+'&password='+pass));
    login:= DHTTPClient.HTTPMethod('POST','https://152.206.129.20:8443/login/Login');
    if login and (Pos('Location:',DHTTPClient.Headers.Text)>0) and (Pos('token',DHTTPClient.Headers.Text)>0) then
    begin
      tokenlocation:=Copy(DHTTPClient.Headers.Text,Pos('Location: ',DHTTPClient.Headers.Text)+10,length(DHTTPClient.Headers.Text));
      tokenlocation:=Copy(tokenlocation,0,Pos(#10,tokenlocation)-1);
      tokenlocation:=StringReplace(tokenlocation,'mi.cubacel.net','152.206.129.20',[rfReplaceAll]);
      DHTTPClient.HTTPMethod('GET',tokenlocation);
    end
    else
    begin
      login:=false;
      errormessage:='Error de comunicación con el portal, tiene algun cortafuegos?';
      retry:=true;
    end;
    if (Pos('badcredentials',DHTTPClient.Headers.Text)>0) then
    begin
      badcredentials:=true;
      errormessage:='Número o contraseña incorrectos, puede registarse o recuperar la contraseña en https://mi.cubacel.net';
    end;
    if (Pos('404 Not Found',DHTTPClient.Headers.Text)>0) then
    begin
      errormessage:='El portal mi.cubacel.net se encuentra fuera de servicio, intente mas tarde.';
      retry:=true;
    end;
  end;
  except on e:exception do
   errormessage:=Self.DumpExceptionCallStack(E);
  end;}
  jhttpclient1.trustAllCertificates();
  jHttpClient1.ClearNameValueData;
  jHttpClient1.AddClientHeader('Content-Type', 'application/x-www-form-urlencoded');
  jHttpClient1.AddClientHeader('User-Agent', 'Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36');
  cookie:=jHttpClient1.AddCookie('https://mi.cubacel.net/login/images/cimg/86.jpg','verify','false');
  //jHttpClient1.GetAsync('https://mi.cubacel.net/login/images/cimg/86.jpg');
  jHttpClient1.AddNameValueData('language', 'es_ES');
  jHttpClient1.AddNameValueData('username', user);
  jHttpClient1.AddNameValueData('password', pass);
  jHttpClient1.AddNameValueData('uword', 'every');
  jhttpClient1.PostNameValueDataAsync('https://mi.cubacel.net:8443/login/Login');
  //jhttpclient1.GetAsync(dominio);
  jTemporizador.Enabled:=true;
  jTemporizador.Interval:=5000;
end;

{function TMainModule.fphttpget(url:string):boolean;
begin
  try
    DHTTPClient.Clear;
    DHTTPClient.HTTPMethod('GET',URL);
    DHTTPClient.Document.Position:=0;
    if DHTTPClient.Document.Size>0 then
      rawcontent:=ReadStrFromStream(DHTTPClient.Document,DHTTPClient.Document.Size);
  except on e:exception do
   errormessage:=Self.DumpExceptionCallStack(E);
  end;
  result:=false;
end;}

procedure TMainModule.flotar;
begin
  if jwmBubble.CanDrawOverlays() then
  begin
    if flotando=false then
    begin
      if (lX <> -1) and (lY <> -1) then
        jwmBubble.SetViewPosition(lX, lY);
      flotando:=true;
      jwmBubble.AddView(jpBubble.View);
      bubblerefresh;
    end;
  end
  else
  begin
    PermissionModule.jCustomDialog1.Show();
  end;
end;

procedure TMainModule.parsehtmldata(data:string);
var
  doc:thtmldocument;
  els:tdomnodelist;
  i:integer;
  n:integer=0;
  s:integer=0;
  sbolsadiaria,sbolsanauta,sbonolte,ssololte,stodas,snacionales,sbonificados,ssaldo,sbonosaldo,sdeuda,sbonovoz,sbonosms,sbreakline:string;
  iexbolsadiaria:integer=-1;
  iexbolsanauta:integer=-1;
  iexbonolte:integer=-1;
  //iexsololte:integer=-1;
  //iextodas:integer=-1;
  //iexnavegacion:integer=-1;
  iexnacionales:integer=-1;
  iexbonificados:integer=-1;
  moneda:string='';
  expiredates, expireaccount:array of string;
  saldos,bonosaldos:array of string;
begin
  if AndroidModule4.jchbEmoticons.Checked then
  begin
    sbolsadiaria:=cebolsadiaria;
    sbolsanauta:=cebolsanauta;
    sbonolte:=cebonolte;
    ssololte:=cesololte;
    stodas:=cetodas;
    snacionales:=cenacionales;
    sbonificados:=cebonificados;
    stime:=cetime;
    ssaldo:=cesaldo;
    sbonosaldo:=cebonosaldo;
    sdeuda:=cedeuda;
    sbonovoz:=cebonovoz;
    sbonosms:=cebonosms;
    sbreakline:=cebreakline;
  end
  else
  begin
    sbolsadiaria:=csbolsadiaria;
    sbolsanauta:=csbolsanauta;
    sbonolte:=csbonolte;
    ssololte:=cssololte;
    stodas:=cstodas;
    snacionales:=csnacionales;
    sbonificados:=csbonificados;
    stime:=cstime;
    ssaldo:=cssaldo;
    sbonosaldo:=csbonosaldo;
    sdeuda:=csdeuda;
    sbonovoz:=csbonovoz;
    sbonosms:=csbonosms;
    sbreakline:=csbreakline;
  end;
  try                                            //asegurar que este el html completo
    if (data<>'') and (data<>'null object') and (Pos('<span class="label bold"> Número de Teléfono:',data)>0) and (Pos('Todos los derechos reservados </div></div></div></div></div></div></div></div></div></body></html>',data)>0) then
    begin
      //if Pos('https://mi.cubacel.net/primary/_-iV1sdikyLAJ',data)>0 then
      //  postpaid:=true;
      //if Pos('https://mi.cubacel.net/primary/_-ijqJlSHh',data)>0 then
        //postpaid:=false;
      //AndroidModule2.jchbPostpaid.Checked:=postpaid;
      //DHTTPClient.Document.Position:=0;
      readhtmlfile(doc,tstringstream.Create(data));
      if postpaid then
      begin
        /////////////////////////////////////////////////////////
        n:=0;
        els:=doc.GetElementsByTagName('span');
        if els.Count>0 then
          bubbletext:='';
        for i:=0 to els.Count-1 do
        begin
          if tdomelement(els[i]).hasAttribute('class') then
          begin
            if (tdomelement(els[i]).GetAttribute('class')='cvalue') then
            begin
              if n=1 then
                bubbletext:=bubbletext+sbonovoz+tdomelement(els[i]).TextContent+sbreakline;
              if n=2 then
                bubbletext:=bubbletext+sbonosms+tdomelement(els[i]).TextContent+sbreakline;
              if n=3 then
                bubbletext:=bubbletext+stodas+tdomelement(els[i]).TextContent+sbreakline;
              inc(n);
            end;
          end;
        end;
        lastdateupdate:=Now();
        //////////////////////////////////////////////////////////
      end
      else
      begin
        setlength(expiredates,0);
        setlength(expireaccount,0);
        setlength(bonosaldos,0);
        //setlength(saldos,0);
        els:=doc.GetElementsByTagName('div');
        if els.Count>0 then
          bubbletext:='';
        for i:=0 to els.Count-1 do
        begin
          if tdomelement(els[i]).hasAttribute('id') then
          begin
            if tdomelement(els[i]).GetAttribute('id')='myStat_bonusVOZI' then
            begin
              inc(n);
            end;
            if tdomelement(els[i]).GetAttribute('id')='myStat_bonusSMSI' then
            begin
              inc(n);
            end;
            if tdomelement(els[i]).GetAttribute('id')='myStat_bonusDataN' then
            begin
              if tdomelement(els[i]).hasAttribute('data-text') and tdomelement(els[i]).hasAttribute('data-info') then
                dnacionales:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');
              iexnacionales:=n;
              inc(n);
            end;

            if tdomelement(els[i]).GetAttribute('id')='myStat_bonusData' then
            begin
              if tdomelement(els[i]).hasAttribute('data-text') and tdomelement(els[i]).hasAttribute('data-info') then
                dbonificados:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');
              iexbonificados:=n;
              inc(n);
            end;

            if tdomelement(els[i]).GetAttribute('id')='myStat_30012' then
            begin
              if tdomelement(els[i]).hasAttribute('data-text') and tdomelement(els[i]).hasAttribute('data-info') then
                dlte:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');
              iexbonolte:=n;
              inc(n);
            end;

            if tdomelement(els[i]).GetAttribute('id')='myStat_3001' then
            begin
              if tdomelement(els[i]).hasAttribute('data-text') and tdomelement(els[i]).hasAttribute('data-info') then
                dnavegacion:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');
              //iexnavegacion:=n;
              inc(n);
            end;

            if tdomelement(els[i]).GetAttribute('id')='myStat_2002' then
            begin
              if tdomelement(els[i]).hasAttribute('data-text') and tdomelement(els[i]).hasAttribute('data-info') then
                dbolsacorreo:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');
              iexbolsanauta:=n;
              inc(n)
            end;

            if tdomelement(els[i]).GetAttribute('id')='myStat_2001' then
            begin
              if tdomelement(els[i]).hasAttribute('data-text') and tdomelement(els[i]).hasAttribute('data-info') then
                dbolsadiaria:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');
              iexbolsadiaria:=n;
              inc(n)
            end;
          end;

          if tdomelement(els[i]).hasAttribute('class') then
          begin
            if tdomelement(els[i]).GetAttribute('class')='network_all' then
            begin
              if Pos('Para todas las redes:',tdomelement(els[i]).TextContent)>0 then
              begin
                dtodas:=tdomelement(els[i]).TextContent;
                dtodas:=Copy(dtodas,Pos('Para todas las redes:',dtodas)+21,length(dtodas));
                dtodas:=Copy(dtodas,0,Pos('B',dtodas)+1);
                dtodas:=StringReplace(dtodas,' ','',[rfReplaceAll]);
              end;
              if Pos('Solo para 4G/LTE:',tdomelement(els[i]).TextContent)>0 then
              begin
                dsololte:=tdomelement(els[i]).TextContent;
                dsololte:=Copy(dsololte,Pos('Solo para 4G/LTE:',dsololte)+17,length(dsololte));
                dsololte:=Copy(dsololte,0,Pos('B',dsololte)+1);
                dsololte:=StringReplace(dsololte,' ','',[rfReplaceAll]);
              end;
            end;
            if tdomelement(els[i]).GetAttribute('class')='expires_date' then
            begin
              setlength(expiredates,length(expiredates)+1);
              expiredates[length(expiredates)-1]:=tdomelement(els[i]).TextContent;
            end;
            if tdomelement(els[i]).GetAttribute('class')='expires_hours' then
            begin
              expiredates[length(expiredates)-1]:=expiredates[length(expiredates)-1]+tdomelement(els[i]).TextContent;
            end;
          end;
        end;
        els:=doc.GetElementsByTagName('span');
        if els.Count>0 then
          setlength(saldos,0);
        for i:=0 to els.Count-1 do
        begin
          if tdomelement(els[i]).hasAttribute('class') then
          begin
            if (tdomelement(els[i]).GetAttribute('class')='mbcHlightValue_msdp') then
            begin
              setlength(saldos,length(saldos)+1);
              saldos[length(saldos)-1]:=StringReplace(tdomelement(els[i]).TextContent,' ','',[rfReplaceAll]);
              //saldos[length(saldos)-1]:=StringReplace(saldos[length(saldos)-1],'CUC','',[rfReplaceAll]);
              //saldos[length(saldos)-1]:=StringReplace(saldos[length(saldos)-1],'CUP','',[rfReplaceAll]);
            end;
            if (tdomelement(els[i]).GetAttribute('class')='cvalue') then
            begin
              setlength(expireaccount,length(expireaccount)+1);
              expireaccount[length(expireaccount)-1]:=tdomelement(els[i]).TextContent;
            end;
            if (tdomelement(els[i]).GetAttribute('class')='cvalue bold cuc-font') then
            begin
              setlength(bonosaldos,length(bonosaldos)+1);
              bonosaldos[length(bonosaldos)-1]:=StringReplace(tdomelement(els[i]).TextContent,' ','',[rfReplaceAll]);
              //bonosaldos[length(bonosaldos)-1]:=StringReplace(bonosaldos[length(bonosaldos)-1],'CUC','',[rfReplaceAll]);
              //bonosaldos[length(bonosaldos)-1]:=StringReplace(bonosaldos[length(bonosaldos)-1],'CUP','',[rfReplaceAll]);
            end;
          end;
        end;

        if (dsololte='') or (dsololte='0B')  then
          dtodas:=dnavegacion;

        if stringtobytes(lastdataslte)<stringtobytes(dsololte) then
          lastdataslte:=dsololte;
        if stringtobytes(lastdatablte)<stringtobytes(dlte) then
          lastdatablte:=dlte;
        if stringtobytes(lastdatatodas)<stringtobytes(dtodas) then
          lastdatatodas:=dtodas;
        if stringtobytes(lastdatanac)<stringtobytes(dnacionales) then
          lastdatanac:=dnacionales;
        if stringtobytes(lastdataboni)<stringtobytes(dbonificados) then
          lastdataboni:=dbonificados;
        if stringtobytes(lastdatamail)<stringtobytes(dbolsacorreo) then
          lastdatamail:=dbolsacorreo;
        if stringtobytes(lastdatadaily)<stringtobytes(dbolsadiaria) then
          lastdatadaily:=dbolsadiaria;
        if (length(saldos)>0) and (stringtomoney(lastdatasaldo)<stringtomoney(saldos[0])) then
          lastdatasaldo:=saldos[0];
        if (length(bonosaldos)>2) and (stringtomoney(lastdatabonosaldo)<stringtomoney(bonosaldos[2])) then
          lastdatabonosaldo:=bonosaldos[2];

        //Consumo diario
        //Necesitamos saber si la ultima fecha guardada tiene menos de 24 h
        if MinutesBetween(Date(), DateOf(lastdatetime))>=1440 then
        begin
          lastdatetime:=Date();
          lastdataslte:=dsololte;
          lastdatablte:=dlte;
          lastdatatodas:=dtodas;
          lastdatanac:=dnacionales;
          lastdatamail:=dbolsacorreo;
          lastdatadaily:=dbolsadiaria;
          if length(saldos)>0 then
            lastdatasaldo:=saldos[0];
          if length(bonosaldos)>0 then
            lastdatabonosaldo:=bonosaldos[0];
          jPreferences1.SetStringData('lastdatetime',datetimetostr(Date()));
          jPreferences1.SetStringData('lastdataslte',lastdataslte);
          jPreferences1.SetStringData('lastdatablte',lastdatablte);
          jPreferences1.SetStringData('lastdatatodas',lastdatatodas);
          jPreferences1.SetStringData('lastdatanac',lastdatanac);
          jPreferences1.SetStringData('lastdataboni',lastdataboni);
          jPreferences1.SetStringData('lastdatamail',lastdatamail);
          jPreferences1.SetStringData('lastdatadaily',lastdatadaily);
          jPreferences1.SetStringData('lastdatasaldo',lastdatasaldo);
          jPreferences1.SetStringData('lastdatabonosaldo',lastdatabonosaldo);
        end;


        if dbolsadiaria<>'' then
          AndroidModule3.jchbBolsaDiaria.Text:='Bolsa Diaria ('+sbolsadiaria+dbolsadiaria+')';
        if dbolsacorreo <> '' then
          AndroidModule3.jchbBolsaNauta.Text:='Bolsa Nauta ('+sbolsanauta+dbolsacorreo+')';
        if (dlte<>'') and havedata(dlte) then
          AndroidModule3.jchbBonoLTE.Text:='Bono LTE ('+sbonolte+dlte+')';
        if dsololte<>'' then
          AndroidModule3.jchbSoloLTE.Text:='LTE ('+ssololte+dsololte+')';
        if dtodas<>'' then
          AndroidModule3.jchbAllNetworks.Text:='2G-3G ('+stodas+dtodas+')';
        if dnacionales<>'' then
          AndroidModule3.jchbNacionales.Text:='Nacionales ('+snacionales+dnacionales+')';
        if dbonificados<>'' then
          AndroidModule3.jchbBonificados.Text:='Datos Bonificados ('+sbonificados+dbonificados+')';
        if length(saldos)>0 then
          AndroidModule3.jchbSaldo.Text:='Saldo ('+ssaldo+saldos[0]+')';
        if length(bonosaldos)>2 then
          AndroidModule3.jchbBonoSaldo.Text:='Bono Saldo ('+sbonosaldo+bonosaldos[2]+')';
        if (length(saldos)>1) and havedata(saldos[1]) then
          AndroidModule3.jchbDeuda.Text:='Deuda ('+sdeuda+saldos[1]+')';


       case typeshow of
         0:begin
            //Saldo
            if AndroidModule3.jchbSaldo.Checked and (length(saldos)>0) then
              bubbletext:=bubbletext+ssaldo+saldos[0]+sbreakline;

            //Bono Saldo
            if AndroidModule3.jchbBonoSaldo.Checked and (length(bonosaldos)>2) then
              bubbletext:=bubbletext+sbonosaldo+bonosaldos[2]+sbreakline;

            //Deuda
            if AndroidModule3.jchbDeuda.Checked and (length(saldos)>1) and havedata(saldos[1]) then
              bubbletext:=bubbletext+sdeuda+saldos[1]+sbreakline;

            //Bolsa Diaria
            if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
              bubbletext:=bubbletext+sbolsadiaria+bytestostring(stringtobytes(dbolsadiaria),digitos)+sbreakline;

            //Bolsa Nauta
            if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
              bubbletext:=bubbletext+sbolsanauta+bytestostring(stringtobytes(dbolsacorreo),digitos)+sbreakline;

            //Bono LTE
            if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
              bubbletext:=bubbletext+sbonolte+bytestostring(stringtobytes(dlte),digitos)+sbreakline;

            //Solo LTE
            if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
              bubbletext:=bubbletext+ssololte+bytestostring(stringtobytes(dsololte),digitos)+sbreakline;

            //Para todas las redes
            if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
              bubbletext:=bubbletext+stodas+bytestostring(stringtobytes(dtodas),digitos)+sbreakline;

            //Nacionales
            if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
              bubbletext:=bubbletext+snacionales+bytestostring(stringtobytes(dnacionales),digitos)+sbreakline;

            //Bonificados
            if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
              bubbletext:=bubbletext+sbonificados+bytestostring(stringtobytes(dbonificados),digitos)+sbreakline;
          end;
         1:begin
            //Saldo
            if AndroidModule3.jchbSaldo.Checked and (length(saldos)>0) then
              bubbletext:=bubbletext+ssaldo+'-'+moneydaily(lastdatasaldo,saldos[0])+sbreakline;

            //Bono Saldo
            if AndroidModule3.jchbBonoSaldo.Checked and (length(bonosaldos)>2) then
              bubbletext:=bubbletext+sbonosaldo+'-'+moneydaily(lastdatabonosaldo,bonosaldos[2])+sbreakline;

            //Deuda no hay gasto en la deuda
            //if AndroidModule3.jchbDeuda.Checked and (length(saldos)>1) and havedata(saldos[1]) then
              //bubbletext:=bubbletext+sdeuda+'-'+saldos[1]+sbreakline;

            //Bolsa Diaria
            if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
              bubbletext:=bubbletext+sbolsadiaria+'-'+datadaily(lastdatadaily,dbolsadiaria)+sbreakline;

            //Bolsa Nauta
            if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
              bubbletext:=bubbletext+sbolsanauta+'-'+datadaily(lastdatamail,dbolsacorreo)+sbreakline;

            //Bono LTE
            if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
              bubbletext:=bubbletext+sbonolte+'-'+datadaily(lastdatablte,dlte)+sbreakline;

            //Solo LTE
            if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
              bubbletext:=bubbletext+ssololte+'-'+datadaily(lastdataslte,dsololte)+sbreakline;

            //Para todas las redes
            if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
              bubbletext:=bubbletext+stodas+'-'+datadaily(lastdatatodas,dtodas)+sbreakline;

            //Nacionales
            if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
              bubbletext:=bubbletext+snacionales+'-'+datadaily(lastdatanac,dnacionales)+sbreakline;

            //Bonificados
            if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
              bubbletext:=bubbletext+sbonificados+'-'+datadaily(lastdataboni,dbonificados)+sbreakline;
          end;
         2:begin
            //Saldo
            if AndroidModule3.jchbSaldo.Checked and (length(saldos)>0) then
              bubbletext:=bubbletext+ssaldo+saldos[0]+'|-'+moneydaily(lastdatasaldo,saldos[0])+moneda+sbreakline;

            //Bono Saldo
            if AndroidModule3.jchbBonoSaldo.Checked and (length(bonosaldos)>2) then
              bubbletext:=bubbletext+sbonosaldo+bonosaldos[2]+'|-'+moneydaily(lastdatabonosaldo,bonosaldos[2])+moneda+sbreakline;

            //Deuda
            if AndroidModule3.jchbDeuda.Checked and (length(saldos)>1) and havedata(saldos[1]) then
              bubbletext:=bubbletext+sdeuda+saldos[1]+'| Deuda'+sbreakline;

            //Bolsa Diaria
            if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
              bubbletext:=bubbletext+sbolsadiaria+bytestostring(stringtobytes(dbolsadiaria),digitos)+'|-'+datadaily(lastdatadaily,dbolsadiaria)+sbreakline;

            //Bolsa Nauta
            if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
              bubbletext:=bubbletext+sbolsanauta+bytestostring(stringtobytes(dbolsacorreo),digitos)+'|-'+datadaily(lastdatamail,dbolsacorreo)+sbreakline;

            //Bono LTE
            if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
              bubbletext:=bubbletext+sbonolte+bytestostring(stringtobytes(dlte),digitos)+'|-'+datadaily(lastdatablte,dlte)+sbreakline;

            //Solo LTE
            if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
              bubbletext:=bubbletext+ssololte+bytestostring(stringtobytes(dsololte),digitos)+'|-'+datadaily(lastdataslte,dsololte)+sbreakline;

            //Para todas las redes
            if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
              bubbletext:=bubbletext+stodas+bytestostring(stringtobytes(dtodas),digitos)+'|-'+datadaily(lastdatatodas,dtodas)+sbreakline;

            //Nacionales
            if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
              bubbletext:=bubbletext+snacionales+bytestostring(stringtobytes(dnacionales),digitos)+'|-'+datadaily(lastdatanac,dnacionales)+sbreakline;

            //Bonificados
            if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
              bubbletext:=bubbletext+sbonificados+bytestostring(stringtobytes(dbonificados),digitos)+'|-'+datadaily(lastdataboni,dbonificados)+sbreakline;
         end;
         3:begin
            //Saldo
            if AndroidModule3.jchbSaldo.Checked and (length(saldos)>0) and (length(expireaccount)>1) then
              bubbletext:=bubbletext+ssaldo+saldos[0]+'| '+expireaccount[1]+sbreakline;

            //Bono Saldo
            if AndroidModule3.jchbBonoSaldo.Checked and (length(bonosaldos)>2) and (length(expireaccount)>2) then
              bubbletext:=bubbletext+sbonosaldo+bonosaldos[2]+'| '+expireaccount[2]+sbreakline;

            //Deuda
            if AndroidModule3.jchbDeuda.Checked and (length(saldos)>1) and havedata(saldos[1]) then
              bubbletext:=bubbletext+sdeuda+saldos[1]+'| Deuda'+sbreakline;

            //Bolsa Diaria
            if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) and (length(expiredates)>iexbolsadiaria) and (iexbolsadiaria>=0) then
              bubbletext:=bubbletext+sbolsadiaria+bytestostring(stringtobytes(dbolsadiaria),digitos)+'| '+expiredates[iexbolsadiaria]+sbreakline;

            //Bolsa Nauta
            if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) and (length(expiredates)>iexbolsanauta) and (iexbolsanauta>=0) then
              bubbletext:=bubbletext+sbolsanauta+bytestostring(stringtobytes(dbolsacorreo),digitos)+'| '+expiredates[iexbolsanauta]+sbreakline;

            //Bono LTE
            if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) and (length(expiredates)>iexnacionales) and (iexnacionales>=0) then
              bubbletext:=bubbletext+sbonolte+bytestostring(stringtobytes(dlte),digitos)+'| '+expiredates[iexbonolte]+sbreakline;

            //Solo LTE
            if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) and (length(expiredates)>iexnacionales) and (iexnacionales>=0) then
              bubbletext:=bubbletext+ssololte+bytestostring(stringtobytes(dsololte),digitos)+'| '+expiredates[iexnacionales]+sbreakline;

            //Para todas las redes
            if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) and (length(expiredates)>iexnacionales) and (iexnacionales>=0) then
              bubbletext:=bubbletext+stodas+bytestostring(stringtobytes(dtodas),digitos)+'| '+expiredates[iexnacionales]+sbreakline;

            //Nacionales
            if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) and (length(expiredates)>iexnacionales) and (iexnacionales>=0) then
              bubbletext:=bubbletext+snacionales+bytestostring(stringtobytes(dnacionales),digitos)+'| '+expiredates[iexnacionales]+sbreakline;

            //Bonificados
            if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) and (length(expiredates)>iexbonificados) and (iexbonificados>=0) then
              bubbletext:=bubbletext+sbonificados+bytestostring(stringtobytes(dbonificados),digitos)+'| '+expiredates[iexbonificados]+sbreakline;
         end;
        end;
        //bubbletext:=bubbletext+#10+traffictext;
        //Hora de ultima actializacion
        lastdateupdate:=Now();
        //FreeAndNil(expiredates);
        //FreeAndNil(expireaccount);
        //FreeAndNil(saldos);
        //FreeAndNil(bonosaldos);
      end;
      if AndroidModule3.jchbTime.Checked then
      begin
        bubbletext:=bubbletext+stime+timetostr(now);
      end
      else
      begin
        if Pos(sbreakline,bubbletext)>0 then
          bubbletext:=Copy(bubbletext,0,length(bubbletext)-1);
      end;
      //FreeAndNil(doc);
      //FreeAndNil(els);
    end;
  except on e:exception do
   errormessage:=Self.DumpExceptionCallStack(E);
  end;
end;

//procedure TMainModule.parsetemplate(data:string);
//var
//  parser:THtmlTemplateParser;
//  sbolsadiaria,sbolsanauta,sbonolte,ssololte,stodas,snacionales,sbonificados,ssaldo,sbonosaldo,sdeuda,sbonovoz,sbonosms,sbreakline:string;
//begin
//  if AndroidModule4.jchbEmoticons.Checked then
//  begin
//    sbolsadiaria:=cebolsadiaria;
//    sbolsanauta:=cebolsanauta;
//    sbonolte:=cebonolte;
//    ssololte:=cesololte;
//    stodas:=cetodas;
//    snacionales:=cenacionales;
//    sbonificados:=cebonificados;
//    stime:=cetime;
//    ssaldo:=cesaldo;
//    sbonosaldo:=cebonosaldo;
//    sdeuda:=cedeuda;
//    sbonovoz:=cebonovoz;
//    sbonosms:=cebonosms;
//    sbreakline:=cebreakline;
//  end
//  else
//  begin
//    sbolsadiaria:=csbolsadiaria;
//    sbolsanauta:=csbolsanauta;
//    sbonolte:=csbonolte;
//    ssololte:=cssololte;
//    stodas:=cstodas;
//    snacionales:=csnacionales;
//    sbonificados:=csbonificados;
//    stime:=cstime;
//    ssaldo:=cssaldo;
//    sbonosaldo:=csbonosaldo;
//    sdeuda:=csdeuda;
//    sbonovoz:=csbonovoz;
//    sbonosms:=csbonosms;
//    sbreakline:=csbreakline;
//  end;
//  try
//  if (data<>'') and (Pos('The service is temporarily unavailable',data)<1) then
//  begin
//    bubbletext:='';
//    parser:= THtmlTemplateParser.create;
//    //parser.KeepPreviousVariables:=kpvForget;
//    if postpaid then
//    begin
//      parser.parseTemplate('<div class="textboxes">*'+
//      '<span class="label bold"></span>'+
//      '<span class="cvalue">?{$postdata}</span>'+
//      '</div>');
//      parser.parseHTML(data);
//      if parser.variableChangeLog.hasVariable('postdata') then
//      begin
//        if parser.variableChangeLog.count>0 then
//          bubbletext:=bubbletext+sbonovoz+parser.variableChangeLog.Values['postdata'].get(0).toString+sbreakline;
//        if parser.variableChangeLog.count>1 then
//          bubbletext:=bubbletext+sbonosms+parser.variableChangeLog.Values['postdata'].get(1).toString+sbreakline;
//        if parser.variableChangeLog.count>2 then
//          bubbletext:=bubbletext+sbonificados+parser.variableChangeLog.Values['postdata'].get(2).toString+sbreakline;
//      end;
//    end
//    else
//    begin
//      //saldos
//      parser.parseTemplate('<span class="cvalue bold cuc-font">?*'+
//      '<span class="mbcHlightValue_msdp">{$saldos}</span>?</span>');
//      parser.parseHTML(data);
//      if parser.variableChangeLog.hasVariable('saldos') then
//      begin
//        if parser.variableChangeLog.count>0 then
//          saldo:=parser.variableChangeLog.get(0).toString;
//        if parser.variableChangeLog.count>1 then
//          deuda:=parser.variableChangeLog.get(1).toString;
//      end;
//
//      //Bono saldo
//      parser.parseTemplate('<div class="myaccount_details_block">?*'+
//      '<div class="mad_row_header"><div class="col1"><span class="label"></span>'+
//      '</div><div class="col2"><span class="label"></span>'+
//      '<span class="cvalue bold cuc-font">{$saldo}</span>'+
//      '</div></div><div class="mad_row_footer"><div class="col2">'+
//      '<span class="label bold"></span><span class="cvalue">{$expsaldo}</span>'+
//      '</div></div></div>');
//      parser.parseHTML(data);
//      if parser.variableChangeLog.hasVariable('expsaldo') then
//      begin
//        expiresaldo:=parser.variableChangeLog.Values['expsaldo'].toString;
//        if parser.variableChangeLog.Values['expsaldo'].Count>1 then
//          expbonosaldo:=parser.variableChangeLog.Values['expsaldo'].get(1).toString;
//      end;
//      if parser.variableChangeLog.hasVariable('saldo') then
//      begin
//        if parser.variableChangeLog.Values['saldo'].Count>1 then
//          bonosaldo:=parser.variableChangeLog.Values['saldo'].get(1).toString;
//      end;
//
//      //////TODAS y solo LTE
//      parser.parseTemplate('<div class="network_all">?<b></b>{$sololte}</div><br><div class="network_all_cero">?<b></b>{$todas}</div></br>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('sololte') then
//      begin
//        dsololte:=parser.variables.values['sololte'].toString;
//        dsololte:=Copy(dsololte,Pos('Solo para 4G/LTE:',dsololte)+17,length(dsololte));
//        dsololte:=Copy(dsololte,0,Pos('B',dsololte)+1);
//        dsololte:=StringReplace(dsololte,' ','',[rfReplaceAll]);
//      end;
//      if parser.variables.hasVariable('todas') then
//      begin
//        dtodas:=parser.variables.values['todas'].toString;
//        dtodas:=Copy(dtodas,Pos('Para todas las redes:',dtodas)+21,length(dtodas));
//        dtodas:=Copy(dtodas,0,Pos('B',dtodas)+1);
//        dtodas:=StringReplace(dtodas,' ','',[rfReplaceAll]);
//      end;
//
//      //Nacionales
//      parser.parseTemplate('<div>?<div><div>'+
//      '<div id="myStat_bonusDataN" data-dimension="260" data-text="{$nacionales}" data-info="{$infonacionales}">'+
//      '</div></div></div><div><div class="expires_date_block">'+
//      '<div class="expires_date">{$expnacionales}</div>'+
//      '<div class="expires_hours">{$infoexpnac}</div></div></div></div>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('nacionales') and parser.variables.hasVariable('infonacionales') then
//        dnacionales:=parser.variables.values['nacionales'].toString+parser.variables.values['infonacionales'].toString;
//      if parser.variables.hasVariable('expnacionales') and parser.variables.hasVariable('infoexpnac') then
//        expnacionales:=parser.variables.values['expnacionales'].toString+parser.variables.values['infoexpnac'].toString;
//
//      //LTE
//      parser.parseTemplate('<div id="myStat_30012" data-text="{$lte}" data-info="{$inflte}">?</div>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('lte') and parser.variables.hasVariable('infolte') then
//        dlte:=parser.variables.values['lte'].toString+parser.variables.values['infolte'].toString;
//
//      //Navegacion
//      parser.parseTemplate('<div id="myStat_3001" data-text="{$navegacion}" data-info="{$infnavegacion}">?</div>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('navegacion') and parser.variables.hasVariable('infonavegacion') then
//        dnavegacion:=parser.variables.values['navegacion'].toString+parser.variables.values['infonavegacion'].toString;
//
//      //Bolsa correo
//      parser.parseTemplate('<div>?<div><div>'+
//      '<div id="myStat_2002" data-dimension="260" data-text="{$bolsacorreo}" data-info="{$infobolsacorreo}">'+
//      '</div></div></div><div><div class="expires_date_block">'+
//      '<div class="expires_date">{$expbolsacorreo}</div>'+
//      '<div class="expires_hours">{$infoexpbolsacorreo}</div></div></div></div>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('bolsacorreo') and parser.variables.hasVariable('infobolsacorreo') then
//        dbolsacorreo:=parser.variables.values['bolsacorreo'].toString+parser.variables.values['infobolsacorreo'].toString;
//      if parser.variables.hasVariable('expbolsacorreo') and parser.variables.hasVariable('infoexpbolsacorreo') then
//        expbolsacorreo:=parser.variables.values['expbolsacorreo'].toString+parser.variables.values['infoexpbolsacorreo'].toString;
//
//      //Bolsa diaria
//      parser.parseTemplate('<div>?<div><div>'+
//      '<div id="myStat_2001" data-dimension="260" data-text="{$bolsdiaria}" data-info="{$infobolsadiaria}">'+
//      '</div></div></div><div><div class="expires_date_block">'+
//      '<div class="expires_date">{$expbolsadiaria}</div>'+
//      '<div class="expires_hours">{$infoexpbolsadiaria}</div></div></div></div>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('bolsadiaria') and parser.variables.hasVariable('infobolsadiaria') then
//        dbolsadiaria:=parser.variables.values['bolsadiaria'].toString+parser.variables.values['infobolsadiaria'].toString;
//      if parser.variables.hasVariable('expbolsadiaria') and parser.variables.hasVariable('infoexpbolsadiaria') then
//        expbolsadiaria:=parser.variables.values['expbolsadiaria'].toString+parser.variables.values['infoexpbolsadiaria'].toString;
//
//      //Bono datos
//      parser.parseTemplate('<div>?<div><div>'+
//      '<div id="myStat_bonusData" data-dimension="260" data-text="{$bonodatos}" data-info="{$infobonodatos}">'+
//      '</div></div></div><div><div class="expires_date_block">'+
//      '<div class="expires_date">{$expbonodatos}</div>'+
//      '<div class="expires_hours">{$infoexpbonodatos}</div></div></div></div>');
//      parser.parseHTML(data);
//      if parser.variables.hasVariable('bonodatos') and parser.variables.hasVariable('infobonodatos') then
//        dbonificados:=parser.variables.values['bonodatos'].toString+parser.variables.values['infobonodatos'].toString;
//      if parser.variables.hasVariable('expbonodatos') and parser.variables.hasVariable('infoexpbonodatos') then
//        expbonodatos:=parser.variables.values['expbonodatos'].toString+parser.variables.values['infoexpbonodatos'].toString;
//
//
//      //gapp.ShowMessage('Datos',numero+' '+saldo+' '+expiresaldo+' -'+deuda+' '+nacionales+' '+expnacionales+#10+navegacion+' LTE:'+lte,'Ok');
//      ///////////////////////////////////////////////////////////////////////////////////////
//      if (dsololte='') or (dsololte='0B')  then
//        dtodas:=dnavegacion;
//
//      if stringtobytes(lastdataslte)<stringtobytes(dsololte) then
//        lastdataslte:=dsololte;
//      if stringtobytes(lastdatablte)<stringtobytes(dlte) then
//        lastdatablte:=dlte;
//      if stringtobytes(lastdatatodas)<stringtobytes(dtodas) then
//        lastdatatodas:=dtodas;
//      if stringtobytes(lastdatanac)<stringtobytes(dnacionales) then
//        lastdatanac:=dnacionales;
//      if stringtobytes(lastdataboni)<stringtobytes(dbonificados) then
//        lastdataboni:=dbonificados;
//      if stringtobytes(lastdatamail)<stringtobytes(dbolsacorreo) then
//        lastdatamail:=dbolsacorreo;
//      if stringtobytes(lastdatadaily)<stringtobytes(dbolsadiaria) then
//        lastdatadaily:=dbolsadiaria;
//      if (stringtomoney(lastdatasaldo)<stringtomoney(saldo)) then
//        lastdatasaldo:=saldo;
//      if stringtomoney(lastdatabonosaldo)<stringtomoney(bonosaldo) then
//        lastdatabonosaldo:=bonosaldo;
//
//      //Consumo diario
//      //Necesitamos saber si la ultima fecha guardada tiene menos de 24 h
//      if MinutesBetween(Date(), DateOf(lastdatetime))>=1440 then
//      begin
//        lastdatetime:=Date();
//        lastdataslte:=dsololte;
//        lastdatablte:=dlte;
//        lastdatatodas:=dtodas;
//        lastdatanac:=dnacionales;
//        lastdatamail:=dbolsacorreo;
//        lastdatadaily:=dbolsadiaria;
//        if saldo<>'' then
//          lastdatasaldo:=saldo;
//        if bonosaldo<>'' then
//          lastdatabonosaldo:=bonosaldo;
//        jPreferences1.SetStringData('lastdatetime',datetimetostr(Date()));
//        jPreferences1.SetStringData('lastdataslte',lastdataslte);
//        jPreferences1.SetStringData('lastdatablte',lastdatablte);
//        jPreferences1.SetStringData('lastdatatodas',lastdatatodas);
//        jPreferences1.SetStringData('lastdatanac',lastdatanac);
//        jPreferences1.SetStringData('lastdataboni',lastdataboni);
//        jPreferences1.SetStringData('lastdatamail',lastdatamail);
//        jPreferences1.SetStringData('lastdatadaily',lastdatadaily);
//        jPreferences1.SetStringData('lastdatasaldo',lastdatasaldo);
//        jPreferences1.SetStringData('lastdatabonosaldo',lastdatabonosaldo);
//      end;
//
//
//      if dbolsadiaria<>'' then
//        AndroidModule3.jchbBolsaDiaria.Text:='Bolsa Diaria ('+sbolsadiaria+dbolsadiaria+')';
//      if dbolsacorreo <> '' then
//        AndroidModule3.jchbBolsaNauta.Text:='Bolsa Nauta ('+sbolsanauta+dbolsacorreo+')';
//      if (dlte<>'') and havedata(dlte) then
//        AndroidModule3.jchbBonoLTE.Text:='Bono LTE ('+sbonolte+dlte+')';
//      if dsololte<>'' then
//        AndroidModule3.jchbSoloLTE.Text:='LTE ('+ssololte+dsololte+')';
//      if dtodas<>'' then
//        AndroidModule3.jchbAllNetworks.Text:='2G-3G ('+stodas+dtodas+')';
//      if dnacionales<>'' then
//        AndroidModule3.jchbNacionales.Text:='Nacionales ('+snacionales+dnacionales+')';
//      if dbonificados<>'' then
//        AndroidModule3.jchbBonificados.Text:='Datos Bonificados ('+sbonificados+dbonificados+')';
//      if saldo<>'' then
//        AndroidModule3.jchbSaldo.Text:='Saldo ('+ssaldo+saldo+')';
//      if bonosaldo<>'' then
//        AndroidModule3.jchbBonoSaldo.Text:='Bono Saldo ('+sbonosaldo+bonosaldo+')';
//      if deuda<>'' then
//        AndroidModule3.jchbDeuda.Text:='Deuda ('+sdeuda+deuda+')';
//
//
//       case typeshow of
//       0:begin
//          //Saldo
//          if AndroidModule3.jchbSaldo.Checked then
//            bubbletext:=bubbletext+ssaldo+saldo+sbreakline;
//
//          //Bono Saldo
//          if AndroidModule3.jchbBonoSaldo.Checked and havedata(bonosaldo) then
//            bubbletext:=bubbletext+sbonosaldo+bonosaldo+sbreakline;
//
//          //Deuda
//          if AndroidModule3.jchbDeuda.Checked and havedata(deuda) then
//            bubbletext:=bubbletext+sdeuda+deuda+sbreakline;
//
//          //Bolsa Diaria
//          if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
//            bubbletext:=bubbletext+sbolsadiaria+bytestostring(stringtobytes(dbolsadiaria),digitos)+sbreakline;
//
//          //Bolsa Nauta
//          if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
//            bubbletext:=bubbletext+sbolsanauta+bytestostring(stringtobytes(dbolsacorreo),digitos)+sbreakline;
//
//          //Bono LTE
//          if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
//            bubbletext:=bubbletext+sbonolte+bytestostring(stringtobytes(dlte),digitos)+sbreakline;
//
//          //Solo LTE
//          if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
//            bubbletext:=bubbletext+ssololte+bytestostring(stringtobytes(dsololte),digitos)+sbreakline;
//
//          //Para todas las redes
//          if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
//            bubbletext:=bubbletext+stodas+bytestostring(stringtobytes(dtodas),digitos)+sbreakline;
//
//          //Nacionales
//          if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
//            bubbletext:=bubbletext+snacionales+bytestostring(stringtobytes(dnacionales),digitos)+sbreakline;
//
//          //Bonificados
//          if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
//            bubbletext:=bubbletext+sbonificados+bytestostring(stringtobytes(dbonificados),digitos)+sbreakline;
//        end;
//       1:begin
//          //Saldo
//          if AndroidModule3.jchbSaldo.Checked then
//            bubbletext:=bubbletext+ssaldo+'-'+moneydaily(lastdatasaldo,saldo)+sbreakline;
//
//          //Bono Saldo
//          if AndroidModule3.jchbBonoSaldo.Checked and havedata(bonosaldo) then
//            bubbletext:=bubbletext+sbonosaldo+'-'+moneydaily(lastdatabonosaldo,bonosaldo)+sbreakline;
//
//          //Deuda no hay gasto en la deuda
//          //if AndroidModule3.jchbDeuda.Checked and (length(saldos)>1) and havedata(saldos[1]) then
//            //bubbletext:=bubbletext+sdeuda+'-'+saldos[1]+sbreakline;
//
//          //Bolsa Diaria
//          if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
//            bubbletext:=bubbletext+sbolsadiaria+'-'+datadaily(lastdatadaily,dbolsadiaria)+sbreakline;
//
//          //Bolsa Nauta
//          if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
//            bubbletext:=bubbletext+sbolsanauta+'-'+datadaily(lastdatamail,dbolsacorreo)+sbreakline;
//
//          //Bono LTE
//          if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
//            bubbletext:=bubbletext+sbonolte+'-'+datadaily(lastdatablte,dlte)+sbreakline;
//
//          //Solo LTE
//          if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
//            bubbletext:=bubbletext+ssololte+'-'+datadaily(lastdataslte,dsololte)+sbreakline;
//
//          //Para todas las redes
//          if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
//            bubbletext:=bubbletext+stodas+'-'+datadaily(lastdatatodas,dtodas)+sbreakline;
//
//          //Nacionales
//          if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
//            bubbletext:=bubbletext+snacionales+'-'+datadaily(lastdatanac,dnacionales)+sbreakline;
//
//          //Bonificados
//          if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
//            bubbletext:=bubbletext+sbonificados+'-'+datadaily(lastdataboni,dbonificados)+sbreakline;
//        end;
//       2:begin
//          //Saldo
//          if AndroidModule3.jchbSaldo.Checked then
//            bubbletext:=bubbletext+ssaldo+saldo+'|-'+moneydaily(lastdatasaldo,saldo)+sbreakline;
//
//          //Bono Saldo
//          if AndroidModule3.jchbBonoSaldo.Checked and havedata(bonosaldo) then
//            bubbletext:=bubbletext+sbonosaldo+bonosaldo+'|-'+moneydaily(lastdatabonosaldo,bonosaldo)+sbreakline;
//
//          //Deuda
//          if AndroidModule3.jchbDeuda.Checked and havedata(deuda) then
//            bubbletext:=bubbletext+sdeuda+deuda+'| Deuda'+sbreakline;
//
//          //Bolsa Diaria
//          if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
//            bubbletext:=bubbletext+sbolsadiaria+bytestostring(stringtobytes(dbolsadiaria),digitos)+'|-'+datadaily(lastdatadaily,dbolsadiaria)+sbreakline;
//
//          //Bolsa Nauta
//          if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
//            bubbletext:=bubbletext+sbolsanauta+bytestostring(stringtobytes(dbolsacorreo),digitos)+'|-'+datadaily(lastdatamail,dbolsacorreo)+sbreakline;
//
//          //Bono LTE
//          if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
//            bubbletext:=bubbletext+sbonolte+bytestostring(stringtobytes(dlte),digitos)+'|-'+datadaily(lastdatablte,dlte)+sbreakline;
//
//          //Solo LTE
//          if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
//            bubbletext:=bubbletext+ssololte+bytestostring(stringtobytes(dsololte),digitos)+'|-'+datadaily(lastdataslte,dsololte)+sbreakline;
//
//          //Para todas las redes
//          if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
//            bubbletext:=bubbletext+stodas+bytestostring(stringtobytes(dtodas),digitos)+'|-'+datadaily(lastdatatodas,dtodas)+sbreakline;
//
//          //Nacionales
//          if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
//            bubbletext:=bubbletext+snacionales+bytestostring(stringtobytes(dnacionales),digitos)+'|-'+datadaily(lastdatanac,dnacionales)+sbreakline;
//
//          //Bonificados
//          if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
//            bubbletext:=bubbletext+sbonificados+bytestostring(stringtobytes(dbonificados),digitos)+'|-'+datadaily(lastdataboni,dbonificados)+sbreakline;
//       end;
//       3:begin
//          //Saldo
//          if AndroidModule3.jchbSaldo.Checked then
//            bubbletext:=bubbletext+ssaldo+saldo+'| '+expiresaldo+sbreakline;
//
//          //Bono Saldo
//          if AndroidModule3.jchbBonoSaldo.Checked and havedata(bonosaldo) then
//            bubbletext:=bubbletext+sbonosaldo+bonosaldo+'| '+expbonosaldo+sbreakline;
//
//          //Deuda
//          if AndroidModule3.jchbDeuda.Checked and havedata(deuda) then
//            bubbletext:=bubbletext+sdeuda+deuda+'| Deuda'+sbreakline;
//
//          //Bolsa Diaria
//          if AndroidModule3.jchbBolsaDiaria.Checked and havedata(dbolsadiaria) then
//            bubbletext:=bubbletext+sbolsadiaria+bytestostring(stringtobytes(dbolsadiaria),digitos)+'| '+expbolsadiaria+sbreakline;
//
//          //Bolsa Nauta
//          if AndroidModule3.jchbBolsaNauta.Checked and havedata(dbolsacorreo) then
//            bubbletext:=bubbletext+sbolsanauta+bytestostring(stringtobytes(dbolsacorreo),digitos)+'| '+expbolsacorreo+sbreakline;
//
//          //Bono LTE
//          if AndroidModule3.jchbBonoLTE.Checked and havedata(dlte) then
//            bubbletext:=bubbletext+sbonolte+bytestostring(stringtobytes(dlte),digitos)+'| '+expnacionales+sbreakline;
//
//          //Solo LTE
//          if AndroidModule3.jchbSoloLTE.Checked and havedata(dsololte) then
//            bubbletext:=bubbletext+ssololte+bytestostring(stringtobytes(dsololte),digitos)+'| '+expnacionales+sbreakline;
//
//          //Para todas las redes
//          if AndroidModule3.jchbAllNetworks.Checked and havedata(dtodas) then
//            bubbletext:=bubbletext+stodas+bytestostring(stringtobytes(dtodas),digitos)+'| '+expnacionales+sbreakline;
//
//          //Nacionales
//          if AndroidModule3.jchbNacionales.Checked and havedata(dnacionales) then
//            bubbletext:=bubbletext+snacionales+bytestostring(stringtobytes(dnacionales),digitos)+'| '+expnacionales+sbreakline;
//
//          //Bonificados
//          if AndroidModule3.jchbBonificados.Checked and havedata(dbonificados) then
//            bubbletext:=bubbletext+sbonificados+bytestostring(stringtobytes(dbonificados),digitos)+'| '+expbonodatos+sbreakline;
//       end;
//      end;
//      //bubbletext:=bubbletext+#10+traffictext;
//      //Hora de ultima actializacion
//    end;
//      if AndroidModule3.jchbTime.Checked then
//      begin
//        bubbletext:=bubbletext+stime+timetostr(now);
//      end
//      else
//      begin
//        if Pos(sbreakline,bubbletext)>0 then
//          bubbletext:=Copy(bubbletext,0,length(bubbletext)-1);
//      end;
//      lastdateupdate:=Now();
//      FreeAndNil(parser);
//    end;
//    //else
//      //ShowMessage('html vacio');
//  except on e:exception do
//   ShowMessage(Self.DumpExceptionCallStack(E));
//  end;
//end;

procedure TMainModule.MainModuleJNIPrompt(Sender: TObject);
var
  myMenu: jObjectRef;
begin
  jsToolbar1.SetFitsSystemWindows(True);
  if AndroidModule2 = nil then
   begin
       gApp.CreateForm(TAndroidModule2, AndroidModule2);
       AndroidModule2.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule3 = nil then
   begin
      gApp.CreateForm(TAndroidModule3, AndroidModule3);
      AndroidModule3.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule4 = nil then
   begin
      gApp.CreateForm(TAndroidModule4, AndroidModule4);
      AndroidModule4.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule5 = nil then
   begin
      gApp.CreateForm(TAndroidModule5, AndroidModule5);
      AndroidModule5.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule6 = nil then
   begin
      gApp.CreateForm(TAndroidModule6, AndroidModule6);
      AndroidModule6.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if TranferModule = nil then
   begin
      gApp.CreateForm(TTranferModule, TranferModule);
      TranferModule.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if CallModule = nil then
   begin
      gApp.CreateForm(TCallModule, CallModule);
      CallModule.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule7 = nil then
   begin
      gApp.CreateForm(TAndroidModule7, AndroidModule7);
      AndroidModule7.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule8 = nil then
   begin
      gApp.CreateForm(TAndroidModule8, AndroidModule8);
      AndroidModule8.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule9 = nil then
   begin
      gApp.CreateForm(TAndroidModule9, AndroidModule9);
      AndroidModule9.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule10 = nil then
   begin
      gApp.CreateForm(TAndroidModule10, AndroidModule10);
      AndroidModule10.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AndroidModule11 = nil then
   begin
      gApp.CreateForm(TAndroidModule11, AndroidModule11);
      AndroidModule11.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if RechargModule = nil then
   begin
      gApp.CreateForm(TRechargModule, RechargModule);
      RechargModule.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if FriendModule = nil then
   begin
      gApp.CreateForm(TFriendModule, FriendModule);
      FriendModule.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if PermissionModule = nil then
   begin
      gApp.CreateForm(TPermissionModule, PermissionModule);
      PermissionModule.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;
   if AboutModule = nil then
   begin
      gApp.CreateForm(TAboutModule, AboutModule);
      AboutModule.Init(gApp);
               //NOTE: form "ActiveMode = actEasel" dont show!
   end;

  //AndroidModule4.jtvTransparent.MarginTop:=200;
  //AndroidModule4.jtvTransparent.Anchor:=nil;

  //jsCoordinatorLayout1.SetFitsSystemWindows(True);
  jsAppBarLayout1.SetFitsSystemWindows(True);
  jsTabLayout1.SetFitsSystemWindows(true);

  //jsToolbar1.AsActionBar:= True;             //need be seted in design time!

  jsToolbar1.SetScrollFlag(csfEnterAlways);

  //jsViewPager1.SetClipToPadding(False);
  jsViewPager1.AddPage(AndroidModule2.jPLogin.View, 'Cubacel');
  jsViewPager1.AddPage(AndroidModule3.jPPreferences.View, 'Ajustes');
  jsViewPager1.AddPage(AndroidModule4.jPAppearance.View, 'Colores');
  jsViewPager2.AddPage(AndroidModule5.View, '');//Consultas
  jsViewPager2.AddPage(AndroidModule8.View, '');//Saldo
  jsViewPager2.AddPage(AndroidModule6.View, '');//SIM
  jsViewPager2.AddPage(AndroidModule7.View, '');//USIM
  jsViewPager2.AddPage(AndroidModule9.View, '');//Plan de voz
  jsViewPager2.AddPage(AndroidModule10.View, '');//Plan SMS
  jsViewPager2.AddPage(AndroidModule11.View, '');//Plan Amigos



  //jsViewPager1.SetAppBarLayoutScrollingViewBehavior();
  loadpreferences;
  activityupdate;
  jsTabLayout1.SetTabGravity(tgFill);
  jsTabLayout1.SetSelectedTabIndicatorColor(colbrLime);
  jsTabLayout1.SetSelectedTabIndicatorHeight(3);
  jsTabLayout1.SetFitsSystemWindows(true);



  jsNavigationView1.AddHeaderView('bg_material', 'ic_launcher', 'Burbuja de datos '+self.GetVersionName(), 150);
  //myMenu:= jsNavigationView1.AddMenu(''); // make a group
  //or
  myMenu:= jsNavigationView1.GetMenu();  //no group

  jsNavigationView1.AddItem(myMenu, 105, 'Consultas', '');
  jsNavigationView1.AddItem(myMenu, 106, 'Burbuja', '');
  jsNavigationView1.AddItem(myMenu, 107, 'Colores', '');
  jsNavigationView1.AddItem(myMenu, 104, 'Ayuda', '');
  jsNavigationView1.AddItem(myMenu, 101, 'Acerca de...', '');
  jsNavigationView1.AddItem(myMenu, 102, 'Código fuente', '');
  jsNavigationView1.AddItem(myMenu, 103, 'Salir', '');

  jsViewPager1.MarginTop:=jsAppBarLayout1.Height+5;
  jsViewPager2.MarginTop:=jsAppBarLayout1.Height+5;

  jsFloatingButton1.SetAnchorGravity(lgBottomRight, jsViewPager1.Id);
  jsFloatingButton1.BringToFront();

  updateinterface;

  AndroidModule2.jtvinfo.Text:=info;



  if (MainModule.jwmBubble.IgnoringBatteryOptimizations()=false) or MainModule.jwmBubble.isAffectedByDataSaver() or (MainModule.jwmBubble.CanDrawOverlays()=false) then
  begin
    PermissionModule.jCustomDialog1.Show();
  end
  else
  begin
    if showtraffic and (flotando=false) then
       flotar;
  end;

  if jTimerConnection.Enabled=false then
  begin
    if (flotando=false) and login and (manualremove=false) then
      MainModule.flotar;
  end;
  if (startData='bubble-start') then
  begin
    manualremove:=false;
    Self.MoveTaskToBack(true);
  end;
  jTimerConnection.Interval:=1000;
  jTimerConnection.Enabled:=true;
end;

{procedure TMainModule.jAsyncTaskGetDoInBackground(Sender: TObject;
  progress: integer; out keepInBackground: boolean);
begin
  //MainModule.DHTTPClient.Abort;
  //micubacellogin(encodeuser,encodepass);
  //keepInBackground:=DoTask(progress);
  keepInBackground:=fphttpget(ip);
end;}

{procedure TMainModule.jAsyncTaskGetPostExecute(Sender: TObject;
  progress: integer);
begin
  minimizeonlogin:=false;
  if (rawcontent<>'') and (Pos('Es necesario acceder',rawcontent)>0) then
  begin
    jTemporizador.Enabled:=false;
    //AndroidModule2.jbLogin.Text:='Acceder';
    login:=false;
    bubbletext:='Reconectando...';
    //jAsyncTaskGet.Done;
    if (AndroidModule2.jetUser.Text<>'') and (AndroidModule2.jetPassword.Text<>'') then
      bubblestart;
  end;
  if (rawcontent<>'') and (Pos('The service is temporarily unavailable',rawcontent)>0) and flotando then
  begin
    bubbletext:='Fuera de servicio!';
  end;
  if (rawcontent<>'') and (Pos('<span class="label bold"> Número de Teléfono: </span>',rawcontent)>0) and login then
  begin
    tmprawcontent:=rawcontent;
    parsehtmldata(tmprawcontent);
    //parsetemplate(tmprawcontent)
  end;
  //jAsyncTaskGet.Done;
end;}

{procedure TMainModule.jAsyncTaskGetPreExecute(Sender: TObject; out
  startProgress: integer);
begin
  startProgress:= 0;
  manualabort:=false;
  if not Assigned(DHTTPClient) then
  begin
    DHTTPClient := THTTPSend.Create;
    //DHTTPClient.KeepAlive:=true;
    //DHTTPClient.Timeout:=5000;
  end;
end;}

{procedure TMainModule.jAsyncTaskGetProgressUpdate(Sender: TObject;
  progress: integer; out progressUpdate: integer);
begin
  ShowMessage(inttostr(progress));
  inc(progressUpdate);
end;}

{procedure TMainModule.jAsyncTaskLoginDoInBackground(Sender: TObject;
  progress: integer; out keepInBackground: boolean);
begin
  if logindelay then
    sleep(5000);
  micubacellogin(encodeuser,encodepass);
  //while(retry) do
  //begin
  //  keepInBackground:=false;
  //  inc(progress);
  //  keepInBackground:=true;
  //  //sleep(5000);
  //  micubacellogin(encodeuser,encodepass);
  //end;
  keepInBackground:=false;
end;}

{procedure TMainModule.jAsyncTaskLoginPostExecute(Sender: TObject;
  progress: integer);
begin
  logindelay:=false;
  if login then
  begin
    jTemporizador.Interval:=3000;
    jTemporizador.Enabled:=true;
    retry:=false;
    bubbletext:='Actualizando...';
    errormessage:='';
    jPreferences1.SetStringData('user',AndroidModule2.jetUser.Text);
    jPreferences1.SetStringData('pass',AndroidModule2.jetPassword.Text);
    AndroidModule2.jbLogin.Text:='Salir';
    if flotando=false then
      flotar;
  end
  else
  begin
    if badcredentials then
    begin
      //MainModule.jDialogProgress1.Close;
      jsTabLayout1.SetPosition(0);;
      AndroidModule2.jbLogin.Text:='Acceder';
      gApp.ShowMessage('Burbuja de datos','Fallo al iniciar cesion'+#10+errormessage,'Ok');
    end
    else
    begin
      inc(retrycount);
      //MainModule.jDialogProgress1.SetMessage(errormessage+#10+'Reintentando ('+inttostr(retrycount)+')...');
    end;
  end;
  jAsyncTaskLogin.Done;
  if retry and (manualabort=false) then
  begin
    logindelay:=true;
    bubbletext:='Reintentando ('+inttostr(retrycount)+')...';
    MainModule.bubblestart;
  end;
end;}

{procedure TMainModule.jAsyncTaskLoginPreExecute(Sender: TObject; out
  startProgress: integer);
begin
  startProgress:=0;
  manualabort:=false;
  encodeuser:=EncodeURLElement(AndroidModule2.jetUser.Text);
  encodepass:=EncodeURLElement(AndroidModule2.jetPassword.Text);
  AndroidModule2.jbLogin.Text:='Salir';
  if not Assigned(DHTTPClient) then
  begin
    DHTTPClient := THTTPSend.Create;
    //DHTTPClient.KeepAlive:=true;
  end;
end;}

{procedure TMainModule.jAsyncTaskLoginProgressUpdate(Sender: TObject;
  progress: integer; out progressUpdate: integer);
begin
  progressUpdate:= progress + 1;
  //MainModule.jDialogProgress1.SetMessage('Portal no disponible, reintento '+inttostr(progress)+'...');
  MainModule.jsFloatingButton1.ShowSnackbar('Portal no disponible, reintento '+inttostr(progress)+'...');
  //AndroidModule2.jDialogProgress1.Show();
end;}

procedure TMainModule.jBroadcastReceiver1Receiver(Sender: TObject;
  intent: jObject);
var
  USSDResponse: string;
  action: string;
begin
   action:= jIntentManager1.GetAction(intent);
   if action = 'org.lamw.action.USSDService' then
   begin
      USSDResponse:= jIntentManager1.GetExtraString(intent, 'message');
      gApp.ShowMessage('Burbuja de datos',USSDResponse,'Ok');
   end;
end;

procedure TMainModule.jcToyTimerService1PullElapsedTime(Sender: TObject;
  elapsedTime: int64);
begin
  if AndroidModule3.jchbNotification.Checked then
  begin
    jNotificationManager1.SetContentIntent(gapp.PackageName, 'App', 'MyCustomDataName','bubble-start');
    jNotificationManager1.SetSubject(stime+timetostr(now));
    jNotificationManager1.SetPriority(npMin);
    //jNotificationManager1.SetBody(timetostr(now));
    //jNotificationManager1.SetTitle(bubbletext);
    jNotificationManager1.Notify();
  end;
end;

procedure TMainModule.jHttpClient1CodeResult(Sender: TObject; code: integer);
begin

end;

procedure TMainModule.jHttpClient1ContentResult(Sender: TObject;
  content: RawByteString);
begin
  rawcontent:=content;
  if (rawcontent<>'') and (Pos('Es necesario acceder',rawcontent)>0) then
  begin
    //jTemporizador.Enabled:=false;
    badcredentials:=false;
    login:=false;
    MainModule.jHttpClient1.ClearCookieStore();
    bubbletext:='Reconectando...';
  end;
  if (rawcontent<>'') and (Pos('The service is temporarily unavailable',rawcontent)>0) and flotando then
  begin
    bubbletext:='Fuera de servicio!';
  end;
  if (rawcontent<>'') and (Pos('&redirectReason=badcredentials',rawcontent)>0) then
  begin
    bubbletext:='';
    jTemporizador.Enabled:=false;
    AndroidModule2.jbLogin.Text:='Acceder';
    login:=false;
    gapp.ShowMessage('Burbuja de datos','Número o contraseña incorrectos, puede registarse o recuperar la contraseña en https://mi.cubacel.net','Ok');
  end;
  if (rawcontent<>'') and (Pos('<div class="page_fullPage_msdp" id="page_Home"><div class="section_contentSection_msdp',rawcontent)>0) and (login=false) then
  begin
    login:=true;
    bubbletext:='Actualizando...';
    jPreferences1.SetStringData('user',AndroidModule2.jetUser.Text);
    jPreferences1.SetStringData('pass',AndroidModule2.jetPassword.Text);
  end;
  if (rawcontent<>'') and (Pos('<span class="label bold"> Número de Teléfono:',rawcontent)>0) and login then
  begin
    tmprawcontent:=rawcontent;
    parsehtmldata(tmprawcontent);
    if jTemporizador.Enabled=false then
    begin
      if jTemporizador.Interval<>Tinterval*1000 then
        jTemporizador.Interval:=Tinterval*1000;
      jTemporizador.Enabled:=true;
    end;
    //parsetemplate(tmprawcontent);
  end;
end;

procedure TMainModule.jPBubbleClick(Sender: TObject);
begin
  //if (jAsyncTaskGet.Running=false) and (jAsyncTaskLogin.Running=false) then
    //jAsyncTaskGet.Execute;
  MainModule.jTemporizadorTimer(nil);
end;

procedure TMainModule.jPBubbleDown(Sender: TObject);
begin
  movecount:=0;
  px:=jwmBubble.GetViewPositionX();
  py:=jwmBubble.GetViewPositionY();
  lx:=px;
  ly:=py;
  jTimerTrash.Interval:=150;
  jTimerTrash.Enabled:=true;
end;

procedure TMainModule.jPBubbleLongClick(Sender: TObject);
begin
  if typeshow<3 then
    inc(typeshow)
  else
    typeshow:=0;
  if (tmprawcontent<>'') then
  begin
    parsehtmldata(tmprawcontent);
    //parsetemplate(tmprawcontent);
    //gettraffic;
  end;
  jPreferences1.SetIntData('typeshow', typeshow);
end;

procedure TMainModule.jPTrashDown(Sender: TObject);
begin
  //HiddeTrash;
  //jwmBubble.RemoveView();
  //flotando:=false;
end;

procedure TMainModule.jsFloatingButton1Click(Sender: TObject);
begin
  if lastactivity='micubacel' then
    lastactivity:='ussd'
  else
    lastactivity:='micubacel';
  activityupdate;
end;

procedure TMainModule.jsNavigationView1ClickItem(Sender: TObject;
  itemId: integer; itemCaption: string);
begin

  if itemID <> 0 then  // itemID = 0 --> subMenu entry point
  begin
      //jMenu1.CheckItem(jObjMenuItem);
      case itemID of
          104:
            begin
              if gapp.APILevel<=20 then
              begin
                if flotando then
                begin
                  MainModule.jwmBubble.RemoveView();
                  flotando:=false;
                end;
              end;
              gApp.ShowMessage('Ayuda','-Puede alternar entre los datos que le restan, el consumo diario o ambos manteniendo presionada la burbuja.'+#10+'-Puede ocultar la burbuja arrastrandola hacia abajo y sobre el circulo rojo que aparece.','Ok');
              if gapp.APILevel<=20 then
                flotar;
            end;
          101:
            begin
              if gapp.APILevel<=20 then
              begin
                if flotando then
                begin
                  MainModule.jwmBubble.RemoveView();
                  flotando:=false;
                end;
              end;
              AboutModule.jCustomDialog1.Show('Acerca de...');
              if gapp.APILevel<=20 then
                flotar;
            end;
          103: Self.Close;
          102:
            begin
              jIntentManager1.SetAction(jIntentManager1.GetActionViewAsString());  //or 'android.intent.action.VIEW'
              jIntentManager1.SetMimeType('text/html');
              jIntentManager1.SetDataUriAsString('https://github.com/Nenirey/databubble');
              if jIntentManager1.ResolveActivity then
                jIntentManager1.StartActivity()
              else
                ShowMessage('El codigo es accesible desde un navegador https://github.com/Nenirey/databubble');
            end;
          105:
            begin
              lastactivity:='ussd';
              activityupdate;
            end;
            106:
            begin
              lastactivity:='micubacel';
              activityupdate;
            end;
            107:
            begin
              lastactivity:='micubacel';
              jsViewPager1.Visible:=true;
              jsViewPager2.Visible:=false;
              jsTabLayout1.SetTabGravity(tgFill);
              jsTabLayout1.SetSelectedTabIndicatorColor(colbrLime);
              jsTabLayout1.SetSelectedTabIndicatorHeight(3);
              jsTabLayout1.SetupWithViewPager(jsViewPager1.View);
              jsTabLayout1.SetFitsSystemWindows(true);
              jsTabLayout1.SetPosition(2);
            end;
      end;
  end;
  //jsDrawerLayout1.Visible:=false;
   jsDrawerLayout1.CloseDrawers();
end;

procedure TMainModule.jTemporizadorTimer(Sender: TObject);
begin
  //if jTemporizador.Interval<>Tinterval*1000 then
    //jTemporizador.Interval:=Tinterval*1000;
  //if (jAsyncTaskGet.Running=false) and (jAsyncTaskLogin.Running=false) then
    //jAsyncTaskGet.Execute;
  if login then
  begin
    if postpaid then
      jhttpclient1.GetAsync(dominiopostpaid)
    else
      jhttpclient1.GetAsync(dominio);
  end
  else
  begin
    if (AndroidModule2.jetUser.Text<>'') and (AndroidModule2.jetPassword.Text<>'') then
      micubacellogin(encodeuser,encodepass);
  end;
end;

procedure TMainModule.jTimerConnectionTimer(Sender: TObject);
begin
  inc(ncheck);
  if hiddeol and (ncheck>4) then
  begin
    if self.IsConnected() then
    begin
      if (flotando=false) and (showtraffic or autostart) and (manualremove=false) then
        MainModule.flotar;
    end
    else
    begin
      if bubbletext<>'Vista previa' then
      begin
        flotando:=false;
        jwmBubble.RemoveView();
      end;
    end;
    ncheck:=0;
  end;
  gettraffic
end;

procedure TMainModule.jTimerTrashTimer(Sender: TObject);
begin
  if (pY<>jwmbubble.GetViewPositionY()) or (pX<>jwmbubble.GetViewPositionX()) then
  begin

    pY:=jwmbubble.GetViewPositionY();
    pX:=jwmbubble.GetViewPositionX();

    if (strash=false)then
      ShowTrash;
    //bubbletext:='pY: '+inttostr(pY)+#10+'pX: '+inttostr(pX)+#10+'tY: '+inttostr(jwmTrash.GetViewPositionY())+#10+'tX: '+inttostr(jwmTrash.GetViewPositionX());
    if  (pY>=jwmTrash.GetViewPositionY()-50) and (pX>=jwmTrash.GetViewPositionX()-50)
    and (pY<=jwmTrash.GetViewPositionY()+50) and (pX<=jwmTrash.GetViewPositionX()+50) then
    begin
      jPBubble.BackgroundColor:=colbrRed;
      jwmBubble.SetRadiusRoundCorner(10);
      jwmBubble.SetViewRoundCorner();
    end
    else
      bubblerefresh;
  end
  else
    inc(movecount);
  if movecount> 6 then
  begin
   jTimerTrash.Enabled:=false;
   if  (pY>=tY-50) and (pX>=tX-50)
   and (pY<=tY+50) and (pX<=tX+50) then
   begin
     pX:=-1;
     pY:=-1;
     manualremove:=true;
     jwmBubble.RemoveView();
     flotando:=false;
     strash:=false;
   end;
   HiddeTrash;
  end;
end;

procedure TMainModule.jtvBubbleLayouting(Sender: TObject; changed: boolean);
var
  s:integer;
begin
  if AndroidModule4.jchbShadow.Checked and changed then
  begin
    //jtvBubble.SetShadowLayer(1.5, 3, 3, colbrCustom);
    if FInitialized then
    begin
       if Pos('$',bubble_shadow_color)>0 then
         And_jni_Bridge.jTextView_SetShadowLayer(MainModule.FjEnv, jtvBubble.jSelf, 1.5 ,3 ,3 , ARGBtoCustomColor(strtocolor(bubble_shadow_color)))
       else
       begin
         trystrtoint(bubble_shadow_color,s);
         jtvBubble.SetShadowLayer(1.5 ,3 ,3 , TARGBColorBridge(s));
         //And_jni_Bridge.jTextView_SetShadowLayer(MainModule.FjEnv, jtvBubble.jSelf, 1.5 ,3 ,3 , TARGBColorBridge(n));
       end;
    end;
  end;
end;

procedure TMainModule.MainModuleActivityCreate(Sender: TObject;
  intentData: jObject);
begin
  startData:= jIntentManager1.GetExtraString(intentData,'MyCustomDataName'); //user defined data
  manualremove:=false;
  if ussdserviceenable then
  begin
    jUSSDService1.Start();
    jBroadcastReceiver1.RegisterIntentActionFilter('org.lamw.action.USSDService');
  end;
end;

procedure TMainModule.MainModuleActivityPause(Sender: TObject);
begin
  savepreferences;
  AndroidModule4.jDrawingView_ColorPick.Visible:=false;
  AndroidModule4.jGridView1.Visible:=false;
  AndroidModule4.jbPreview.Visible:=true;
  AndroidModule4.jtvDrawInfo.Visible:=false;
end;

procedure TMainModule.MainModuleActivityResult(Sender: TObject;
  requestCode: integer; resultCode: TAndroidResult; intentData: jObject);
var
   jContactUri: jObject;
   strContactNumber,abarCode: string;
begin
  if (requestCode = 2003) and (resultcode=RESULT_OK) then
  begin
    strContactNumber:= '';
    jContactUri:= jIntentManager1.GetDataUri(intentData);
    strContactNumber:= jIntentManager1.GetContactNumber(jContactUri);
    ShowMessage(strContactNumber);
    if strContactNumber <> '' then
    begin
      strContactNumber:=StringReplace(strContactNumber,' ','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'(','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,')','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'-','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'+53','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'*99','',[rfReplaceAll]);
      TranferModule.jetPhone.Text:=strContactNumber;
    end;
  end;
  if (requestCode = 3003)  and (resultcode=RESULT_OK) then
  begin
    strContactNumber:= '';
    jContactUri:=jIntentManager1.GetDataUri(intentData);
    strContactNumber:=jIntentManager1.GetContactNumber(jContactUri);
    ShowMessage(strContactNumber);
    if strContactNumber <> '' then
    begin
      strContactNumber:=StringReplace(strContactNumber,' ','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'(','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,')','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'-','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'+53','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'*99','',[rfReplaceAll]);
      CallModule.jetPhone.Text:=strContactNumber;
    end;
  end;
  if (requestCode = 4003)  and (resultcode=RESULT_OK) then
  begin
    strContactNumber:= '';
    jContactUri:= jIntentManager1.GetDataUri(intentData);
    strContactNumber:= jIntentManager1.GetContactNumber(jContactUri);
    ShowMessage(strContactNumber);
    if strContactNumber <> '' then
    begin
      strContactNumber:=StringReplace(strContactNumber,' ','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'(','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,')','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'-','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'+53','',[rfReplaceAll]);
      strContactNumber:=StringReplace(strContactNumber,'*99','',[rfReplaceAll]);
      FriendModule.jetPhone.Text:=strContactNumber;
    end;
  end;
  if (requestCode = 1006)  and (resultcode=RESULT_OK) then
  begin
    if flotando=false then
    begin
      if login then
      begin
        jTemporizador.Interval:=Tinterval*1000;
        jTemporizador.Enabled:=true;
        flotar;
        //Self.Minimize();
      end
      else
      begin
       if (AndroidModule2.jetUser.Text<>'') and (AndroidModule2.jetPassword.Text<>'') then
         bubblestart;
      end;
    end
    else
    begin
      if login then
      begin
        jTemporizador.Interval:=Tinterval*1000;
        jTemporizador.Enabled:=true;
        //Self.Minimize();
      end;
      //else
        //jsTabLayout1.SetPosition(0);
    end;
  end;
  if (requestCode=1987) then  //user def code... for barcode scanned
  begin
    if (resultCode=RESULT_OK) AND (Assigned(intentData)) then  //ok
    begin
      // this is important : setclass !!!!
      jIntentManager1.SetClass('com.google.zxing.client.android', 'CaptureActivity');
      aBarCode:=jIntentManager1.GetExtraString(intentData, 'SCAN_RESULT');
      ShowMessage(aBarCode);
    end else ShowMessage('Fail/cancel to scan....');
  end;
  if (requestcode=1006) or (requestcode=1007) or (requestcode=1008) then
  begin
    if MainModule.jwmBubble.IgnoringBatteryOptimizations()=false then
    begin
      PermissionModule.jtvMessage.Text:='Se necesita ignorar la optimizacion de bateria'+#10#10+'Permitalo a continuacion';
      permiso:='batery';
      PermissionModule.jCustomDialog1.Show();
    end;
    if MainModule.jwmBubble.isAffectedByDataSaver() then
    begin
      PermissionModule.jtvMessage.Text:='Se necesita acceso a los datos sin restricciones'+#10#10+'Active los dos interruptores a continuacion';
      permiso:='data';
      PermissionModule.jCustomDialog1.Show();
    end;
    if MainModule.jwmBubble.CanDrawOverlays()=false then
    begin
      PermissionModule.jtvMessage.Text:='Se necesita permiso para mostrar sobre otras aplicaciones'+#10#10+'Active el interruptor a continuacion';
      permiso:='overlay';
      PermissionModule.jCustomDialog1.Show();
    end;
  end;
end;

procedure TMainModule.MainModuleActivityStart(Sender: TObject);
begin
  //MainModule.jwmBubble.RemoveView();
  //flotando:=false;
  if AndroidModule3.jchbService.Checked and (ifservicerunning=false) then
  begin
    ifservicerunning:=true;
    //ShowMessage('Service Start Running...');
    jcToyTimerService1.Start();
    jcToyTimerService1.Bind();
    jcToyTimerService1.TimerOn();
    jcToyTimerService1.RunForeground();
  end;
  if (AndroidModule2.jetUser.Text<>'') and (AndroidModule2.jetPassword.Text<>'') then
  begin
    if autostart then
    begin
      bubblestart;
    end
    else
      flotar;
  end;
end;

procedure TMainModule.MainModuleActivityStop(Sender: TObject);
begin
  savepreferences;
end;

procedure TMainModule.MainModuleBackButton(Sender: TObject);
begin
  AndroidModule4.jDrawingView_ColorPick.Visible:=false;
  AndroidModule4.jGridView1.Visible:=false;
  AndroidModule4.jtvDrawInfo.Visible:=false;
end;

procedure TMainModule.MainModuleClose(Sender: TObject);
begin
  savepreferences;
  AndroidModule4.jDrawingView_ColorPick.Visible:=false;
  AndroidModule4.jGridView1.Visible:=false;
  AndroidModule4.jtvDrawInfo.Visible:=false;
end;

procedure TMainModule.MainModuleCloseQuery(Sender: TObject;
  var CanClose: boolean);
var
   minimize:boolean=false;
begin
  savepreferences;
  AndroidModule4.jDrawingView_ColorPick.Visible:=false;
  AndroidModule4.jGridView1.Visible:=false;
  AndroidModule4.jtvDrawInfo.Visible:=false;
  if (lastactivity='ussd') then
  begin
    if jsViewPager2.GetPosition()<>0 then
    begin
      jsViewPager2.SetPosition(0);
    end
    else
      minimize:=true;
    Canclose:=false;
  end
  else
  begin
    if flotando or showtraffic then
    begin
      Canclose:=false;
      minimize:=true;
    end
    else
      Canclose:=true;
  end;
  if minimize then
  begin
    MainModule.MoveTaskToBack(true);
  end;
end;

procedure TMainModule.MainModuleDestroy(Sender: TObject);
begin
  savepreferences;
end;

procedure TMainModule.MainModuleInit(Sender: TObject);
begin
  if (startData='bubble-start') then
  begin
    if flotando=false then
      flotar;
    manualremove:=false;
    Self.MoveTaskToBack(true);
  end;
end;

procedure TMainModule.jsToolbar1ClickNavigationIcon(Sender: TObject);
begin
  jsDrawerLayout1.OpenDrawer();
end;

end.
