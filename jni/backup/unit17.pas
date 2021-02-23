{hint: Pascal files location: ...\\jni }
unit unit17;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, customdialog, Laz_And_Controls;
  
type

  { TAboutModule }

  TAboutModule = class(jForm)
    jCustomDialog1: jCustomDialog;
    jPanel1: jPanel;
    jtvOk: jTextView;
    jtvVersion: jTextView;
    jtvLink: jTextView;
    jtvMentions: jTextView;
    procedure AboutModuleJNIPrompt(Sender: TObject);
    procedure jtvLinkClick(Sender: TObject);
    procedure jtvOkClick(Sender: TObject);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AboutModule: TAboutModule;

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TAboutModule }

procedure TAboutModule.AboutModuleJNIPrompt(Sender: TObject);
begin
  jtvVersion.Text:='Burbuja de datos '+Self.GetVersionName();

  jtvMentions.Text:='Esta app es libre bajo la licencia GNU GPL 2.'+#10#10+'Agradecimientos a los beta testers:'+#10+'@AndroidUserCu'+#10+'@El_Profesor_CVR'+#10+'@Ygoogle'+#10#10;

  jtvLink.SetTextAsHtml('Soporte en Telegram: <a href="https://t.me/databubble">https://t.me/databubble</a>');
end;

procedure TAboutModule.jtvLinkClick(Sender: TObject);
begin
  MainModule.jIntentManager1.SetAction(MainModule.jIntentManager1.GetActionViewAsString());  //or 'android.intent.action.VIEW'
  MainModule.jIntentManager1.SetMimeType('text/html');

  MainModule.jIntentManager1.SetDataUriAsString('https://t.me/databubble');
  //or: jIntentManager1.SetDataUri(jIntentManager1.ParseUri('http://forum.lazarus.freepascal.org/index.php/board,43.0.html'));

   if MainModule.jIntentManager1.ResolveActivity then
    MainModule.jIntentManager1.StartActivity()
  else
    ShowMessage('Instale Telegram para unirse al grupo de soporte');
end;

procedure TAboutModule.jtvOkClick(Sender: TObject);
begin
  AboutModule.jCustomDialog1.Close();
end;

end.
