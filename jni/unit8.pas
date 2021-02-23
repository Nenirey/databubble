{Hint: save all files to location: \jni }
unit unit8;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, customdialog, Laz_And_Controls,
  intentmanager;
  
type

  { TCallModule }

  TCallModule = class(jForm)
    jbContact: jButton;
    jbCall99: jButton;
    jbCallAnon: jButton;
    jCustomDialog1: jCustomDialog;
    jetPhone: jEditText;
    jPanel1: jPanel;
    procedure jbCallAnonClick(Sender: TObject);
    procedure jbContactClick(Sender: TObject);
    procedure jbCall99Click(Sender: TObject);
    procedure jCustomDialog1BackKeyPressed(Sender: TObject; title: string);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  CallModule: TCallModule;


implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TCallModule }

procedure TCallModule.jbCall99Click(Sender: TObject);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    if (jetPhone.Text<>'')  then
    begin
      MainModule.jPhoneCall(self.UriEncode('*99'+jetPhone.Text));
      jCustomDialog1.Close();
    end;
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);
end;

procedure TCallModule.jCustomDialog1BackKeyPressed(Sender: TObject;
  title: string);
begin
  if gapp.APILevel<=20 then
  begin
    MainModule.flotar;
  end;
end;

procedure TCallModule.jbContactClick(Sender: TObject);
begin
  if isRunTimePermissionGranted('android.permission.READ_CONTACTS') then
  begin
    MainModule.jIntentManager1.SetAction(iaPick);
    MainModule.jIntentManager1.SetDataUri(MainModule.jIntentManager1.GetContactsPhoneUri());
    if MainModule.jIntentManager1.ResolveActivity() then
    begin
      MainModule.jIntentManager1.StartActivityForResult(3003, 'Seleccione el contacto');
    end
    else
      ShowMessage('Debe instalar una app de contactos');
  end
  else
  begin
    Self.RequestRuntimePermission('android.permission.READ_CONTACTS', 2001);
  end;
end;

procedure TCallModule.jbCallAnonClick(Sender: TObject);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    if (jetPhone.Text<>'')  then
    begin
        MainModule.jPhoneCall(self.UriEncode('#31#'+jetPhone.Text));
      jCustomDialog1.Close();
    end;
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);
end;

end.
