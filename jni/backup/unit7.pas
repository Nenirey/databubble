{Hint: save all files to location: \jni }
unit unit7;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, customdialog, Laz_And_Controls, And_jni,
  intentmanager;
  
type

  { TTranferModule }

  TTranferModule = class(jForm)
    jbOK: jButton;
    jbContact: jButton;
    jCustomDialog1: jCustomDialog;
    jetAmount: jEditText;
    jetPass: jEditText;
    jetPhone: jEditText;
    jPanel1: jPanel;
    procedure jbContactClick(Sender: TObject);
    procedure jbOKClick(Sender: TObject);
    procedure jCustomDialog1BackKeyPressed(Sender: TObject; title: string);
    procedure jCustomDialog1Show(Sender: TObject; dialog: jObject; title: string
      );
    procedure jetAmountChange(Sender: TObject; txt: string; count: integer);
    procedure jetPhoneChange(Sender: TObject; txt: string; count: integer);
    procedure TranferModuleCreate(Sender: TObject);
    procedure TranferModuleJNIPrompt(Sender: TObject);
  private
    {private declarations}
  public
    {public declarations}
    worktype:string;
  end;

var
  TranferModule: TTranferModule;

implementation

uses
  unit1;
{$R *.lfm}
  

{ TTranferModule }

procedure TTranferModule.jbOKClick(Sender: TObject);
begin
  if (worktype='tranfer') and (jetPhone.Text.Length=8) and (jetPass.Text.Length=4) and (jetAmount.Text<>'') then
  begin
    if Pos('.',jetAmount.Text)>0 then
      MainModule.jPhoneCall(self.UriEncode('*234*1*'+jetPhone.Text+'*'+jetPass.Text+'#'))
    else
      MainModule.jPhoneCall(self.UriEncode('*234*1*'+jetPhone.Text+'*'+jetPass.Text+'*'+jetAmount.Text+'#'));
    jCustomDialog1.Close();
  end
  else
    ShowMessage('Complete los campos');
  if (worktype='changepass') and (jetAmount.Text.Length=4) and (jetPass.Text.Length=4) then
  begin
    MainModule.jPhoneCall(self.UriEncode('*234*2*'+jetAmount.Text+'*'+jetPass.Text+'#'));
    jetAmount.Text:='';
    jCustomDialog1.Close();
  end
  else
    ShowMessage('Complete los campos');
end;

procedure TTranferModule.jCustomDialog1BackKeyPressed(Sender: TObject;
  title: string);
begin
  if gapp.APILevel<=20 then
  begin
    MainModule.flotar;
  end;
end;

procedure TTranferModule.jCustomDialog1Show(Sender: TObject; dialog: jObject;
  title: string);
begin

end;

procedure TTranferModule.jetAmountChange(Sender: TObject; txt: string;
  count: integer);
begin

end;

procedure TTranferModule.jetPhoneChange(Sender: TObject; txt: string;
  count: integer);
begin

end;


procedure TTranferModule.TranferModuleCreate(Sender: TObject);
begin

end;

procedure TTranferModule.TranferModuleJNIPrompt(Sender: TObject);
begin
  //jbContact.SetCompoundDrawables('ic_action_person_add',cdsAbove);
end;

procedure TTranferModule.jbContactClick(Sender: TObject);
begin
  if isRunTimePermissionGranted('android.permission.READ_CONTACTS') then
  begin
    MainModule.jIntentManager1.SetAction(iaPick);
    MainModule.jIntentManager1.SetDataUri(jIntentManager1.GetContactsPhoneUri());

    if MainModule.jIntentManager1.ResolveActivity() then
    begin
      MainModule.jIntentManager1.StartActivityForResult(2003, 'Seleccione el contacto');
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
