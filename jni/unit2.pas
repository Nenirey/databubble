{Hint: save all files to location: D:\lamw\projects\databubble\jni }
unit unit2;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls;
  
type

  { TAndroidModule2 }

  TAndroidModule2 = class(jForm)
    jbLogin: jButton;
    jbRegister: jButton;
    jchbPostpaid: jCheckBox;
    jetUser: jEditText;
    jetPassword: jEditText;
    jImageView1: jImageView;
    jPLogin: jPanel;
    jScrollView1: jScrollView;
    jTextView1: jTextView;
    jtvCubacel: jTextView;
    jtvInfo: jTextView;
    procedure AndroidModule2JNIPrompt(Sender: TObject);
    procedure jbLoginClick(Sender: TObject);
    procedure jbRegisterClick(Sender: TObject);
    procedure jchbPostpaidClick(Sender: TObject);
    procedure jetUserEnter(Sender: TObject);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule2: TAndroidModule2;

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TAndroidModule2 }

procedure TAndroidModule2.AndroidModule2JNIPrompt(Sender: TObject);
begin

end;

procedure TAndroidModule2.jbLoginClick(Sender: TObject);
begin
  //if MainModule.jcToyTimerService1.IsTimerRunning()=false then
    //MainModule.jcToyTimerService1.TimerOn();
  if UpperCase(jbLogin.Text)='ACCEDER' then
  begin
    jbLogin.Text:='Salir';
    AndroidModule2.jetUser.Enabled:=false;
    AndroidModule2.jetPassword.Enabled:=false;
    if (jetUser.Text<>'') and (jetPassword.Text<>'') then
    begin
      MainModule.bubblestart;
    end
    else
      gApp.ShowMessage('Burbuja de datos','Debe poner su usuario o número del portal y la contraseña!!!','Ok');
  end
  else
  begin
    jbLogin.Text:='Acceder';
    AndroidModule2.jetUser.Enabled:=true;
    AndroidModule2.jetPassword.Enabled:=true;
    login:=false;
    MainModule.jTemporizador.Enabled:=false;
    //MainModule.jsFloatingButton1.ShowSnackbar('Accediendo...');
    manualabort:=true;
    badcredentials:=false;
    retrycount:=0;
    bubbletext:='';
    if flotando and (showtraffic=false) then
    begin
      MainModule.jwmBubble.RemoveView();
      flotando:=false;
    end;
    MainModule.jHttpClient1.ClearCookieStore();
  end;
end;

procedure TAndroidModule2.jbRegisterClick(Sender: TObject);
begin
  MainModule.jIntentManager1.SetAction('android.intent.action.VIEW');  //or 'android.intent.action.VIEW'
  MainModule.jIntentManager1.SetMimeType('text/html');
  MainModule.jIntentManager1.SetDataUriAsString('https://mi.cubacel.net/');
  if MainModule.jIntentManager1.ResolveActivity then
    MainModule.jIntentManager1.StartActivity()
  else
    ShowMessage('Debe usar un navegador');
end;

procedure TAndroidModule2.jchbPostpaidClick(Sender: TObject);
begin
  postpaid:=jchbPostpaid.checked;
  MainModule.jPreferences1.SetBoolData('postpaid',postpaid);
end;

procedure TAndroidModule2.jetUserEnter(Sender: TObject);
begin
  jetPassword.SetFocus;
  jetPassword.ShowSoftInput();
end;


end.
