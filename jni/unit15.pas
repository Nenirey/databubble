{Hint: save all files to location: \jni }
unit unit15;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, customdialog, Laz_And_Controls,
  intentmanager;
  
type

  { TFriendModule }

  TFriendModule = class(jForm)
    jbOk: jButton;
    jbContact: jButton;
    jCustomDialog1: jCustomDialog;
    jetPhone: jEditText;
    jPanel1: jPanel;
    procedure jbContactClick(Sender: TObject);
    procedure jbOkClick(Sender: TObject);
    procedure jCustomDialog1BackKeyPressed(Sender: TObject; title: string);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  FriendModule: TFriendModule;

implementation

uses
  unit1;

  
{$R *.lfm}
  

{ TFriendModule }

procedure TFriendModule.jbOkClick(Sender: TObject);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    if (jetPhone.Text<>'')  then
    begin
      if jbOk.Text='Agregar' then
        MainModule.jPhoneCall(self.UriEncode('*133*4*2*1*'+jetPhone.Text+'#'));
      if jbOk.Text='Eliminar' then
        MainModule.jPhoneCall(self.UriEncode('*133*4*2*2*'+jetPhone.Text+'#'));
      jCustomDialog1.Close();
    end;
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);
end;

procedure TFriendModule.jCustomDialog1BackKeyPressed(Sender: TObject;
  title: string);
begin
  if gapp.APILevel<=20 then
  begin
    MainModule.flotar;
  end;
end;

procedure TFriendModule.jbContactClick(Sender: TObject);
begin
  if isRunTimePermissionGranted('android.permission.READ_CONTACTS') then
  begin
    MainModule.jIntentManager1.SetAction(iaPick);
    MainModule.jIntentManager1.SetDataUri(MainModule.jIntentManager1.GetContactsPhoneUri());
    if MainModule.jIntentManager1.ResolveActivity() then
    begin
      MainModule.jIntentManager1.StartActivityForResult(4003, 'Seleccione el contacto');
    end
    else
      ShowMessage('Debe instalar una app de contactos');
  end
  else
  begin
    Self.RequestRuntimePermission('android.permission.READ_CONTACTS', 2001);
  end;
end;

end.
