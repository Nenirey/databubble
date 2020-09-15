{Hint: save all files to location: D:\lamw\projects\databubble\jni }
unit main;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, And_jni, windowmanager,
  preferences, Spinner, seekbar, modaldialog, actionbartab, intentmanager, menu,
  drawingview, ssl_openssl, sax_html, dom_html, dom, httpsend, synautil,
  Synacode, openssl;
  
type

  { TMainModule }

  TMainModule = class(jForm)
    jActionBarTab1: jActionBarTab;
    jAsyncTaskGet: jAsyncTask;
    jAsyncTaskLogin: jAsyncTask;
    jbHiddeBubble: jButton;
    jbLogin: jButton;
    jbPreview: jButton;
    jbShowBuuble: jButton;
    jbRegister: jButton;
    jchbNacionales: jCheckBox;
    jchbBonoLTE: jCheckBox;
    jchbSoloLTE: jCheckBox;
    jchbAllNetworks: jCheckBox;
    jchbBolsaDiaria: jCheckBox;
    jchbBolsaNauta: jCheckBox;
    jchbTime: jCheckBox;
    jchbAutoStart: jCheckBox;
    jetPassword: jEditText;
    jetUser: jEditText;
    jIntentManager1: jIntentManager;
    jMenu1: jMenu;
    jModalDialog1: jModalDialog;
    jPTrash: jPanel;
    jPPreferences: jPanel;
    jPAppearance: jPanel;
    jPLogin: jPanel;
    jPBubble: jPanel;
    jPreferences1: jPreferences;
    jsbTransparent: jSeekBar;
    jsbFontSize: jSeekBar;
    jspBColor: jSpinner;
    jspFColor: jSpinner;
    jspInterval: jSpinner;
    jTemporizador: jTimer;
    jtvTrash: jTextView;
    jTimerTrash: jTimer;
    jtvBColor: jTextView;
    jTextView2: jTextView;
    jtvFontSize: jTextView;
    jtvInfo: jTextView;
    jtvInfo1: jTextView;
    jtvCubacel: jTextView;
    jtvdataformat: jTextView;
    jtvInterval: jTextView;
    jtvPassword: jTextView;
    jtvBubble: jTextView;
    jtvTransparent: jTextView;
    jtvUser: jTextView;
    jwmBubble: jWindowManager;
    jwmTrash: jWindowManager;
    procedure jAsyncTaskGetDoInBackground(Sender: TObject; progress: integer; out
      keepInBackground: boolean);
    procedure jAsyncTaskGetPostExecute(Sender: TObject; progress: integer);
    procedure jAsyncTaskLoginDoInBackground(Sender: TObject; progress: integer; out
      keepInBackground: boolean);
    procedure jAsyncTaskLoginPostExecute(Sender: TObject; progress: integer);
    procedure jAsyncTaskLoginPreExecute(Sender: TObject; out startProgress: integer
      );
    procedure jbHiddeBubbleClick(Sender: TObject);
    procedure jbLoginClick(Sender: TObject);
    procedure jbPreviewClick(Sender: TObject);
    procedure jbRegisterClick(Sender: TObject);
    procedure jbShowBuubleClick(Sender: TObject);
    procedure jDrawingView1TouchUp(Sender: TObject; countXY: integer;
      X: array of single; Y: array of single; flingGesture: TFlingGesture;
      pinchZoomScaleState: TPinchZoomScaleState; zoomScale: single);
    procedure jetdataformatChange(Sender: TObject; txt: string; count: integer);
    procedure jPAppearanceFlingGesture(Sender: TObject;
      flingGesture: TFlingGesture);
    procedure jPBubbleClick(Sender: TObject);
    procedure jPBubbleDown(Sender: TObject);
    procedure jPLoginFlingGesture(Sender: TObject; flingGesture: TFlingGesture);
    procedure jPPreferencesFlingGesture(Sender: TObject;
      flingGesture: TFlingGesture);
    procedure jsbFontSizeProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jsbTransparentProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jspBColorItemSelected(Sender: TObject; itemCaption: string;
      itemIndex: integer);
    procedure jspFColorItemSelected(Sender: TObject; itemCaption: string;
      itemIndex: integer);
    procedure jspIntervalItemSelected(Sender: TObject; itemCaption: string;
      itemIndex: integer);
    procedure jTemporizadorTimer(Sender: TObject);
    procedure jTimerTrashTimer(Sender: TObject);
    procedure MainModuleActivityCreate(Sender: TObject; intentData: jObject);
    procedure MainModuleActivityPause(Sender: TObject);
    procedure MainModuleActivityResult(Sender: TObject; requestCode: integer;
      resultCode: TAndroidResult; intentData: jObject);
    procedure MainModuleClickOptionMenuItem(Sender: TObject;
      jObjMenuItem: jObject; itemID: integer; itemCaption: string;
      checked: boolean);
    procedure MainModuleClose(Sender: TObject);
    procedure MainModuleCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure MainModuleCreateOptionMenu(Sender: TObject; jObjMenu: jObject);
    procedure MainModuleJNIPrompt(Sender: TObject);
    procedure flotar;
    procedure parsehtmldata(data:string);
    procedure fphttpget(url:string);
    procedure micubacellogin(user:string;pass:string);
    procedure savepreferences;
    procedure loadpreferences;
    procedure showtrash;
    procedure hiddetrash;
  private
    {private declarations}
  public
    {public declarations}
  end;

const
  info='Nota: Para que esta aplicación funcione adecuadamente:'+#10#10+'1- No la quite de las apps usadas recientemente.'+#10+'2- Permita el uso de datos en segundo plano.'+#10+'3- Permita con ahorro de datos activo.'+#10+'4- Quite la optimización de batería.'+#10#10+'Esta aplicación solo funciona con datos móviles ya que obtiene la información del portal https://mi.cubacel.net  el cual es completamente GRATIS y no resta de sus megas.';



var
  MainModule: TMainModule;
  dnacionales,dnavegacion,dlte,dbolsacorreo,dsololte,dtodas,dbolsadiaria,saldo,deuda:string;
  inacionales,inavegacion,ilte,ibolsacorreo,isololte,itodas,ibolsadiaria:integer;
  focused:boolean;
  information:string;
  flotando:boolean=false;
  htmlcontent:string;
  DHTTPClient:THTTPSend;
  rawcontent:string;
  login:boolean=false;
  tokenlocation,errormessage:string;
  cnum:integer;
  pX,pY:integer;
  movecount:integer;
  strash:boolean=false;

implementation
  
{$R *.lfm}
  

{ TMainModule }

procedure TMainModule.ShowTrash;
begin
  if jwmTrash.CanDrawOverlays() then
  begin
    strash:=true;
    jwmTrash.SetViewPosition(Round(self.GetScreenWidth()/2)-Round(jpTrash.Width/2), Self.GetScreenHeight()-50);
    jPTrash.BackgroundColor:=colbrRed;
    jwmTrash.AddView(jPTrash.View);
    jwmTrash.SetRadiusRoundCorner(60);
    jwmTrash.SetViewRoundCorner();
    jwmTrash.SetViewFocusable(false);
    jPTrash.SetBackgroundAlpha(100);
  end;
end;

procedure TMainModule.hiddetrash;
begin
  strash:=false;
  jwmTrash.RemoveView();
end;

procedure TMainModule.savepreferences;
begin
  jPreferences1.SetIntData('interval',jspinterval.SelectedIndex);
  jPreferences1.SetIntData('transparent',jsbTransparent.Progress);
  jPreferences1.SetIntData('fontsize',jsbFontSize.Progress);
  jPreferences1.SetBoolData('logged',login);
  jPreferences1.SetBoolData('showbolsadiaria',jchbBolsaDiaria.Checked);
  jPreferences1.SetBoolData('showbolsanauta',jchbBolsaNauta.Checked);
  jPreferences1.SetBoolData('showbonolte',jchbBonoLTE.Checked);
  jPreferences1.SetBoolData('showsololte',jchbSoloLTE.Checked);
  jPreferences1.SetBoolData('showallnetoworks',jchbAllNetworks.Checked);
  jPreferences1.SetBoolData('showinternet',jchbNacionales.Checked);
  jPreferences1.SetBoolData('showtime',jchbTime.Checked);
  jPreferences1.SetIntData('backgroudcolor',jspBColor.SelectedIndex);
  jPreferences1.SetIntData('fontcolor',jspFColor.SelectedIndex);
  jPreferences1.SetBoolData('autostart',jchbAutoStart.Checked);
  pX:= jwmBubble.GetViewPositionX();
  pY:= jwmBubble.GetViewPositionY();

  jPreferences1.SetIntData('X', pX);
  jPreferences1.SetIntData('Y', pY);
end;

procedure TMainModule.loadpreferences;
begin
  jspInterval.SelectedIndex:=jPreferences1.GetIntData('interval',2);
  jsbTransparent.Progress:=jPreferences1.GetIntData('transparent',85);
  jsbFontSize.Progress:=jPreferences1.GetIntData('fontsize',0);
  jetUser.Text:=jPreferences1.GetStringData('user','');
  jetPassword.Text:=jPreferences1.GetStringData('pass','');
  login:=jPreferences1.GetBoolData('logged',false);
  jchbBolsaDiaria.Checked:=jPreferences1.GetBoolData('showbolsadiaria',true);
  jchbBolsaNauta.Checked:=jPreferences1.GetBoolData('showbolsanauta',true);
  jchbBonoLTE.Checked:=jPreferences1.GetBoolData('showbonolte',true);
  jchbSoloLTE.Checked:=jPreferences1.GetBoolData('showsololte',true);
  jchbAllNetworks.Checked:=jPreferences1.GetBoolData('showallnetoworks',true);
  jchbNacionales.Checked:=jPreferences1.GetBoolData('showinternet',true);
  jchbTime.Checked:=jPreferences1.GetBoolData('showtime',true);
  jspBColor.SelectedIndex:=jPreferences1.GetIntData('backgroudcolor',0);
  jspFColor.SelectedIndex:=jPreferences1.GetIntData('fontcolor',0);
  jchbAutoStart.Checked:=jPreferences1.GetBoolData('autostart',false);
  pX:= jPreferences1.GetIntData('X', -1);  //  -1 = dummy
  pY:= jPreferences1.GetIntData('Y', -1);
  //cnum:=jPreferences1.GetIntData('cnum',0);
end;

procedure TMainModule.micubacellogin(user:string;pass:string);
//var
  //i:integer;
begin
  if Assigned(DHTTPClient) then
  begin
    login:=false;
    DHTTPClient.Headers.Clear;
    DHTTPClient.Cookies.Clear;
    DHTTPClient.Protocol:='1.1';
    DHTTPClient.MimeType:='application/x-www-form-urlencoded';
    DHTTPClient.KeepAlive:=true;
    DHTTPClient.UserAgent:='Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML like Gecko) Chrome/83.0.4103.106 Mobile Safari/537.36';
    //if cnum = 0 then
    //begin
      WriteStrToStream(DHTTPClient.Document, AnsiString('language=es_ES&username='+EncodeURLElement(user)+'&password='+EncodeURLElement(pass)));
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
      end;
      if (Pos('badcredentials',DHTTPClient.Headers.Text)>0) then
        errormessage:='Número o contraseña incorrectos, puede registarse o recuperar la contraseña en https://mi.cubacel.net';
    //end
    //else
    //begin
      //login:=true;
      //for i:=0 to cnum-1 do
        //DHTTPClient.Cookies.Add(jPreferences1.GetStringData('cookie'+inttostr(i),''));
    //end;
    //end;
  end;
end;

procedure TMainModule.fphttpget(url:string);
begin
  if Assigned(DHTTPClient) then
  begin
    DHTTPClient.Clear;
    DHTTPClient.HTTPMethod('GET',URL);
    DHTTPClient.Document.Position:=0;
    rawcontent:=ReadStrFromStream(DHTTPClient.Document,DHTTPClient.Document.Size);
  end;
end;

procedure TMainModule.flotar;
begin
  case jspBColor.SelectedIndex of
  0: jPBubble.BackgroundColor:=colbrBlack;
  1: jPBubble.BackgroundColor:=colbrWhite;
  2: jPBubble.BackgroundColor:=colbrBlue;
  3: jPBubble.BackgroundColor:=colbrPink;
  end;
  case jspFColor.SelectedIndex of
  0: jtvBubble.FontColor:=colbrWhite;
  1: jtvBubble.FontColor:=colbrYellow;
  2: jtvBubble.FontColor:=colbrRed;
  3: jtvBubble.FontColor:=colbrBlack;
  end;
  if (pX <> -1) and (pY <> -1) then
    jwmBubble.SetViewPosition(pX, pY);
  flotando:=true;
  jwmBubble.AddView(jpBubble.View);
  jwmBubble.SetRadiusRoundCorner(10);
  jwmBubble.SetViewRoundCorner();
  jwmBubble.SetViewFocusable(false);
  jpBubble.SetBackgroundAlpha(Round(jsbTransparent.Progress*2.5));
end;


procedure TMainModule.parsehtmldata(data:string);
var
  doc:thtmldocument;
  els:tdomnodelist;
  i:integer;
  bubbletext:string;
begin
  bubbletext:='';
  if (data<>'') and (data<>'null object') then
  begin
    readhtmlfile(doc,tstringstream.Create(data));
    els:=doc.GetElementsByTagName('div');
    for i:=0 to els.Count-1 do
    begin
      if tdomelement(els[i]).hasAttribute('id') then
      begin
        if tdomelement(els[i]).GetAttribute('id')='myStat_bonusDataN' then
          dnacionales:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');

        if tdomelement(els[i]).GetAttribute('id')='myStat_30012' then
          dlte:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');

        if tdomelement(els[i]).GetAttribute('id')='myStat_3001' then
          dnavegacion:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');

        if tdomelement(els[i]).GetAttribute('id')='myStat_2002' then
          dbolsacorreo:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');

        if tdomelement(els[i]).GetAttribute('id')='myStat_2001' then
          dbolsadiaria:=tdomelement(els[i]).GetAttribute('data-text')+tdomelement(els[i]).GetAttribute('data-info');

        if tdomelement(els[i]).GetAttribute('id')='myaccount_details_block' then
        begin
          //saldo:=tdomelement(els[i]).TextContent;
          //saldo:=StringReplace(saldo,'Mi Cuenta','',[rfReplaceAll]);
          //saldo:=StringReplace(saldo,'Saldo:&nbsp;','',[rfReplaceAll]);
        end;

        if tdomelement(els[i]).GetAttribute('id')='myaccount_details_block' then
        begin
          //deuda:=tdomelement(els[i]).TextContent;
          //deuda:=StringReplace(saldo,'Mi Cuenta','',[rfReplaceAll]);
          //deuda:=StringReplace(saldo,'Saldo:&nbsp;','',[rfReplaceAll]);
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
      end;
    end;

    if (dtodas='') and (dsololte='') then
      dtodas:=dnavegacion;

    {information:=StringReplace(jetDataformat.Text,'%INT%',dnavegacion,[rfReplaceAll]);
    information:=StringReplace(information,'%NAC%',dnacionales,[rfReplaceAll]);
    information:=StringReplace(information,'%LTE%',dlte,[rfReplaceAll]);
    information:=StringReplace(information,'%SLTE%',dsololte,[rfReplaceAll]);
    information:=StringReplace(information,'%TODAS%',dtodas,[rfReplaceAll]);
    information:=StringReplace(information,'%BN%',dbolsacorreo,[rfReplaceAll]);
    information:=StringReplace(information,'%BD%',dbolsadiaria,[rfReplaceAll]);
    information:=StringReplace(information,'%UPDATETIME%',timetostr(now),[rfReplaceAll]);
    information:=StringReplace(information,'%SALDO%',saldo,[rfReplaceAll]);
    information:=StringReplace(information,'%DEUDA%',deuda,[rfReplaceAll]);
    information:=StringReplace(information,'<br>',#10,[rfReplaceAll]);}

    //Bolsa Diaria
    if jchbBolsaDiaria.Checked then
      bubbletext:=bubbletext+'BD: '+dbolsadiaria+#10;
    if dbolsadiaria<>'' then
      jchbBolsaDiaria.Text:='Bolsa Diaria ('+dbolsadiaria+')';

    //Bolsa Nauta
    if jchbBolsaNauta.Checked then
      bubbletext:=bubbletext+'CO: '+dbolsacorreo+#10;
    if dbolsacorreo <> '' then
      jchbBolsaNauta.Text:='Bolsa Nauta ('+dbolsacorreo+')';

    //Bono LTE
    if jchbBonoLTE.Checked then
      bubbletext:=bubbletext+'BL: '+dlte+#10;
    if dlte<>'' then
      jchbBonoLTE.Text:='Bono LTE ('+dlte+')';

    //Solo LTE
    if jchbSoloLTE.Checked then
      bubbletext:=bubbletext+'SL: '+dsololte+#10;
    if dsololte<>'' then
      jchbSoloLTE.Text:='Solo LTE ('+dsololte+')';

    //Para todas las redes
    if jchbAllNetworks.Checked then
      bubbletext:=bubbletext+'3G: '+dtodas+#10;
    if dtodas<>'' then
      jchbAllNetworks.Text:='Para todas las redes ('+dtodas+')';

    //Nacionales
    if jchbNacionales.Checked then
      bubbletext:=bubbletext+'CU: '+dnacionales+#10;
    if dnacionales<>'' then
      jchbNacionales.Text:='Nacionales ('+dnacionales+')';

    //Hora de ultima actializacion
    if jchbTime.Checked then
    begin
      bubbletext:=bubbletext+'Hr: '+timetostr(now);
    end
    else
      bubbletext:=Copy(bubbletext,0,length(bubbletext)-1);


    jtvBubble.Text:=bubbletext;
  end
  else
  begin
    jtvBubble.Text:=information;
  end;
end;

procedure TMainModule.jbLoginClick(Sender: TObject);
begin
  if (jetUser.Text<>'') and (jetPassword.Text<>'') then
  begin
    jbLogin.Enabled:=false;
    if jAsyncTaskLogin.Running=false then
      jAsyncTaskLogin.Execute;
  end
  else
    ShowMessage('Debe poner su usuario o número del portal y la contraseña!!!');
end;

procedure TMainModule.jbPreviewClick(Sender: TObject);
begin
  if jwmBubble.CanDrawOverlays() then
  begin
    if flotando=false then
    begin
      flotar;
    end;
  end
  else
  begin
    ShowMessage('Debe conceder los permisos necesarios para mostrar contenido sobre otras aplicaciones!!!');
    jwmBubble.RequestDrawOverlayRuntimePermission(gApp.PackageName,1006);
  end;
end;

procedure TMainModule.jbRegisterClick(Sender: TObject);
begin
  jIntentManager1.SetAction('android.intent.action.VIEW');  //or 'android.intent.action.VIEW'
  jIntentManager1.SetMimeType('text/html');
  jIntentManager1.SetDataUriAsString('https://mi.cubacel.net/');
  if jIntentManager1.ResolveActivity then
    jIntentManager1.StartActivity()
  else
    ShowMessage('Debe usar un navegador');
end;

procedure TMainModule.jbHiddeBubbleClick(Sender: TObject);
begin
  flotando:=false;
  jTemporizador.Enabled:=false;
  jwmBubble.RemoveView();
end;

procedure TMainModule.jAsyncTaskGetDoInBackground(Sender: TObject;
  progress: integer; out keepInBackground: boolean);
begin
  fphttpget('https://152.206.129.20/primary/_-ijqJlSHh');
  keepInBackground:=false;
end;

procedure TMainModule.jAsyncTaskGetPostExecute(Sender: TObject; progress: integer);
begin
  if Pos('<span class="label bold"> Número de Teléfono: </span>',rawcontent)>0 then
  begin
    parsehtmldata(rawcontent);
    jPreferences1.SetStringData('user',jetUser.Text);
    jPreferences1.SetStringData('pass',jetPassword.Text);
    if jwmBubble.CanDrawOverlays() then
    begin
      if flotando=false then
      begin
       flotar;
       jActionBarTab1.SelectTabByIndex(2);
      end;
    end
    else
    begin
      ShowMessage('Debe conceder los permisos necesarios para mostrar contenido sobre otras aplicaciones!!!');
      jwmBubble.RequestDrawOverlayRuntimePermission(gApp.PackageName,1006);
    end;
  end
  else
    jbLogin.Enabled:=true;
  jAsyncTaskGet.Done;
end;

procedure TMainModule.jAsyncTaskLoginDoInBackground(Sender: TObject;
  progress: integer; out keepInBackground: boolean);
begin
  micubacellogin(jetUser.Text,jetPassword.Text);
  keepInBackground:=false;
end;

procedure TMainModule.jAsyncTaskLoginPostExecute(Sender: TObject; progress: integer);
var
  i:integer;
begin
  if login then
  begin
    ///jModalDialog1.SetDialogMessage('Login ok');
    //jModalDialog1.SetDialogTitle('Burbuja de datos');
    //jModalDialog1.SetDialogMessage(DHTTPClient.Cookies.CommaText);
    //jModalDialog1.ShowMessage(gapp.GetPackageName);
    //jPreferences1.SetIntData('cnum',DHTTPClient.Cookies.Count);
    //for i:=0 to DHTTPClient.Cookies.Count-1 do
      //jPreferences1.SetStringData('cookie'+inttostr(i),DHTTPClient.Cookies[i]);
    if jAsyncTaskGet.Running=false then
      jAsyncTaskGet.Execute;
    jTemporizador.Interval:=strtoint(jspInterval.Text)*1000;
    jTemporizador.Enabled:=true;
  end
  else
  begin
    jModalDialog1.SetDialogTitle('Burbuja de datos');
    jModalDialog1.SetDialogMessage('Fallo al iniciar cesion'+#10+errormessage);
    jModalDialog1.ShowMessage(gapp.GetPackageName);
    jActionBarTab1.SelectTabByIndex(0);
    //ShowMessage('Fallo al iniciar cesion'+#10+errormessage);
    jbLogin.Enabled:=true;
  end;
  jAsyncTaskLogin.Done;
end;

procedure TMainModule.jAsyncTaskLoginPreExecute(Sender: TObject; out
  startProgress: integer);
begin
  startProgress:=0;
  if not Assigned(DHTTPClient) then
  begin
    DHTTPClient := THTTPSend.Create;
    DHTTPClient.KeepAlive:=true;
  end
end;


procedure TMainModule.jbShowBuubleClick(Sender: TObject);
begin
  savepreferences;
  if jwmBubble.CanDrawOverlays() then
  begin
    if flotando=false then
    begin
     if login then
     begin
       jTemporizador.Interval:=strtoint(jspInterval.Text)*1000;
       jTemporizador.Enabled:=true;
       flotar;
       Self.Minimize();
     end
     else
       jActionBarTab1.SelectTabByIndex(0);
    end
    else
      Self.Minimize();
  end
  else
  begin
    ShowMessage('Debe conceder los permisos necesarios para mostrar contenido sobre otras aplicaciones!!!');
    jwmBubble.RequestDrawOverlayRuntimePermission(gApp.PackageName,1006);
  end;
  //jIntentManager1.SetAction('Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS');
  //jIntentManager1.SetDataUriAsString('package:'+gapp.PackageName);
  //jIntentManager1.StartActivityForResult(1007);
end;

procedure TMainModule.jDrawingView1TouchUp(Sender: TObject; countXY: integer;
  X: array of single; Y: array of single; flingGesture: TFlingGesture;
  pinchZoomScaleState: TPinchZoomScaleState; zoomScale: single);
begin
  ShowMessage('Up');
end;

procedure TMainModule.jetdataformatChange(Sender: TObject; txt: string;
  count: integer);
begin
  if txt<>'' then
    jPreferences1.SetStringData('format',txt);
end;

procedure TMainModule.jPAppearanceFlingGesture(Sender: TObject;
  flingGesture: TFlingGesture);
begin
  if flingGesture=fliLeftToRight then
  begin
    jPPreferences.AnimationMode:=animLeftToRight;
    jActionBarTab1.SelectTabByIndex(1);
  end;
end;

procedure TMainModule.jPBubbleClick(Sender: TObject);
begin
  if jAsyncTaskGet.Running=false then
    jAsyncTaskGet.Execute;
end;

procedure TMainModule.jPBubbleDown(Sender: TObject);
begin
  //ShowMessage('Down');
  movecount:=0;
  jTimerTrash.Interval:=150;
  jTimerTrash.Enabled:=true;
end;

procedure TMainModule.jPLoginFlingGesture(Sender: TObject;
  flingGesture: TFlingGesture);
begin
  if flingGesture=fliRightToLeft then
  begin
    jPPreferences.AnimationMode:=animRightToLeft;
    jActionBarTab1.SelectTabByIndex(1);
  end;
end;

procedure TMainModule.jPPreferencesFlingGesture(Sender: TObject;
  flingGesture: TFlingGesture);
begin
  if flingGesture=fliRightToLeft then
  begin
    jPAppearance.AnimationMode:=animRightToLeft;
    jActionBarTab1.SelectTabByIndex(2);
  end;
  if flingGesture=fliLeftToRight then
  begin
    jPLogin.AnimationMode:=animLeftToRight;
    jActionBarTab1.SelectTabByIndex(0);
  end;
end;

procedure TMainModule.jsbFontSizeProgressChanged(Sender: TObject;
  progress: integer; fromUser: boolean);
begin
  if jsbFontSize.Progress>0 then
  begin
    jtvBubble.FontSize:=Round(jsbFontSize.Progress div 4);
    jtvFontSize.Text:='Tamaño de la fuente ('+inttostr(jtvBubble.FontSize)+')';
  end
  else
    jtvFontSize.Text:='Tamaño de la fuente (Por defecto)';
end;

procedure TMainModule.jsbTransparentProgressChanged(Sender: TObject;
  progress: integer; fromUser: boolean);
begin
  jpBubble.SetBackgroundAlpha(Round(jsbTransparent.Progress*2.5));
  jtvTransparent.Text:='Opacidad ('+inttostr(jsbTransparent.Progress)+'%)';
end;

procedure TMainModule.jspBColorItemSelected(Sender: TObject;
  itemCaption: string; itemIndex: integer);
begin
  case itemIndex of
  0: jPBubble.BackgroundColor:=colbrBlack;
  1: jPBubble.BackgroundColor:=colbrWhite;
  2: jPBubble.BackgroundColor:=colbrBlue;
  3: jPBubble.BackgroundColor:=colbrPink;
  end;
  case jspFColor.SelectedIndex of
  0: jtvBubble.FontColor:=colbrWhite;
  1: jtvBubble.FontColor:=colbrYellow;
  2: jtvBubble.FontColor:=colbrRed;
  3: jtvBubble.FontColor:=colbrBlack;
  end;
  jwmBubble.SetRadiusRoundCorner(10);
  jwmBubble.SetViewRoundCorner();
  jpBubble.SetBackgroundAlpha(Round(jsbTransparent.Progress*2.5));
end;

procedure TMainModule.jspFColorItemSelected(Sender: TObject;
  itemCaption: string; itemIndex: integer);
begin
  case itemIndex of
  0: jtvBubble.FontColor:=colbrWhite;
  1: jtvBubble.FontColor:=colbrYellow;
  2: jtvBubble.FontColor:=colbrRed;
  3: jtvBubble.FontColor:=colbrBlack;
  end;
  case jspBColor.SelectedIndex of
  0: jPBubble.BackgroundColor:=colbrBlack;
  1: jPBubble.BackgroundColor:=colbrWhite;
  2: jPBubble.BackgroundColor:=colbrBlue;
  3: jPBubble.BackgroundColor:=colbrPink;
  end;
  jwmBubble.SetRadiusRoundCorner(10);
  jwmBubble.SetViewRoundCorner();
  jpBubble.SetBackgroundAlpha(Round(jsbTransparent.Progress*2.5));
end;

procedure TMainModule.jspIntervalItemSelected(Sender: TObject;
  itemCaption: string; itemIndex: integer);
begin
  jPreferences1.SetIntData('interval',jspinterval.SelectedIndex);
end;

procedure TMainModule.jTemporizadorTimer(Sender: TObject);
begin
  if jAsyncTaskGet.Running=false then
    jAsyncTaskGet.Execute;
end;

procedure TMainModule.jTimerTrashTimer(Sender: TObject);
begin
  if (pY<>jwmbubble.GetViewPositionY()) or (pX<>jwmbubble.GetViewPositionX()) then
  begin
    movecount:=0;
    pY:=jwmbubble.GetViewPositionY();
    pX:=jwmbubble.GetViewPositionX();
    if (pY>Self.GetScreenHeight()/2) and ((pX>Round(self.GetScreenWidth()/2)-Round(jPBubble.Width/2)) and (pX<Round(self.GetScreenWidth()/2))) then
    begin
      if (strash=false)then
        ShowTrash;
    end
    else
    begin
      HiddeTrash;
    end;
  end
  else
    inc(movecount);
  if movecount> 5 then
  begin
   jTimerTrash.Enabled:=false;
   if (pY>Self.GetScreenHeight()-80) and ((pX>Round(self.GetScreenWidth()/2)-Round(jPBubble.Width/2)) and (pX<Round(self.GetScreenWidth()/2))) then
   begin
     jwmBubble.RemoveView();

     flotando:=false;
     strash:=false;
   end;
   jwmTrash.RemoveView();
  end;
end;

procedure TMainModule.MainModuleActivityCreate(Sender: TObject;
  intentData: jObject);
begin
  loadpreferences;
  jTemporizador.Enabled:=false;
  jtvinfo.Text:=info;
  jActionBarTab1.Add('Cubacel', jPLogin.View{sheet view}, '');    // ...\res\drawable-xxx
  jActionBarTab1.Add('Ajustes', jPPreferences.View {sheet view}, ''); //...\res\drawable-xxx
  jActionBarTab1.Add('Apariencia', jPAppearance.View{sheet view},'');
  Self.SetTabNavigationModeActionBar;  //this is needed!!!

  if (jetUser.Text<>'') and (jetPassword.Text<>'') then
  begin
    if jchbAutoStart.Checked then
    begin
      jbLogin.Enabled:=false;
      if jAsyncTaskLogin.Running=false then
        jAsyncTaskLogin.Execute;
    end;
  end;
end;

procedure TMainModule.MainModuleActivityPause(Sender: TObject);
begin
  savepreferences;
end;

procedure TMainModule.MainModuleActivityResult(Sender: TObject;
  requestCode: integer; resultCode: TAndroidResult; intentData: jObject);
begin
  if requestCode = 1006 then
  begin
    if jwmBubble.CanDrawOverlays() then
    begin
      if flotando=false then
      begin
       if jPreferences1.GetBoolData('logged',false) then
       begin
         flotar;
         Self.Minimize();
       end
       else
         jActionBarTab1.SelectTabByIndex(0);
      end;
    end
    else
      ShowMessage('Debe conceder los permisos necesarios para mostrar contenido sobre otras aplicaciones!!!');
  end;
end;

procedure TMainModule.MainModuleClickOptionMenuItem(Sender: TObject;
  jObjMenuItem: jObject; itemID: integer; itemCaption: string; checked: boolean
  );
begin
  if itemID <> 0 then  // itemID = 0 --> subMenu entry point
  begin
      jMenu1.CheckItem(jObjMenuItem);
      case itemID of
          1003:
            begin
              jModalDialog1.SetDialogTitle('Acerca de...');
              jModalDialog1.SetDialogMessage('Burbuja de datos versión '+self.GetVersionName());
              jModalDialog1.ShowMessage(gapp.GetPackageName);
            end;
          1004: Self.Close;
          1005:
            begin
              jIntentManager1.SetAction(jIntentManager1.GetActionViewAsString());  //or 'android.intent.action.VIEW'
              jIntentManager1.SetMimeType('text/html');
              jIntentManager1.SetDataUriAsString('https://github.com/Nenirey/databubble');
              if jIntentManager1.ResolveActivity then
                jIntentManager1.StartActivity()
              else
                ShowMessage('El codigo es accesible desde un navegador https://github.com/Nenirey/databubble');
            end;
      end;
  end;
end;

procedure TMainModule.MainModuleClose(Sender: TObject);
begin
  //savepreferences;
end;

procedure TMainModule.MainModuleCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  savepreferences;
  if flotando then
  begin
    Canclose:=false;
    Self.Minimize();
  end
  else
    Canclose:=true;
end;

procedure TMainModule.MainModuleCreateOptionMenu(Sender: TObject;
  jObjMenu: jObject);
begin
   jMenu1.Add(jObjMenu, 1003 {itemID}, 'Acerca de...');
   jMenu1.Add(jObjMenu, 1005 {itemID}, 'Código fuente');
   jMenu1.Add(jObjMenu, 1004 {itemID}, 'Salir');
end;

procedure TMainModule.MainModuleJNIPrompt(Sender: TObject);
begin

end;

end.
