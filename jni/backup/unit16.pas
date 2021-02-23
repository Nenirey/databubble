{Hint: save all files to location: \jni }
unit unit16;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, customdialog, And_jni;
  
type

  { TPermissionModule }

  TPermissionModule = class(jForm)
    jCustomDialog1: jCustomDialog;
    jPanel1: jPanel;
    jtvMessage: jTextView;
    jtvButton: jTextView;
    procedure jCustomDialog1Show(Sender: TObject; dialog: jObject; title: string
      );
    procedure jtvButtonClick(Sender: TObject);
    procedure PermissionModuleActivityResult(Sender: TObject;
      requestCode: integer; resultCode: TAndroidResult; intentData: jObject);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  PermissionModule: TPermissionModule;
  permiso:string='';

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TPermissionModule }

procedure TPermissionModule.jCustomDialog1Show(Sender: TObject;
  dialog: jObject; title: string);
begin
  if MainModule.jwmBubble.IgnoringBatteryOptimizations()=false then
  begin
    jtvMessage.Text:='Se necesita ignorar la optimizacion de bateria'+#10#10+'Permitalo a continuacion';
    permiso:='batery';
  end;
  if MainModule.jwmBubble.isAffectedByDataSaver() then
  begin
    jtvMessage.Text:='Se necesita acceso a los datos sin restricciones'+#10#10+'Active los dos interruptores a continuacion';
    permiso:='data';
  end;
  if MainModule.jwmBubble.CanDrawOverlays()=false then
  begin
    jtvMessage.Text:='Se necesita permiso para mostrar sobre otras aplicaciones'+#10#10+'Active el interruptor a continuacion';
    permiso:='overlay';
  end;
end;

procedure TPermissionModule.jtvButtonClick(Sender: TObject);
begin
  if permiso='overlay' then
  begin
    MainModule.jwmBubble.RequestDrawOverlayRuntimePermission(gApp.PackageName,1006);
  end;
  if permiso='batery' then
  begin
    MainModule.jwmBubble.RequestIgnoreBatteryOptimizationRuntimePermission(gApp.PackageName,1007);
  end;
  if permiso='data' then
  begin
    MainModule.jwmBubble.RequestIgnoreBackgrundDataRestrictionRuntimePermission(gApp.PackageName,1008);
  end;
  jCustomDialog1.Close();
end;

procedure TPermissionModule.PermissionModuleActivityResult(Sender: TObject;
  requestCode: integer; resultCode: TAndroidResult; intentData: jObject);
begin

end;

end.
