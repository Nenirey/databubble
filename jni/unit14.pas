{Hint: save all files to location: \jni }
unit unit14;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, customdialog, Laz_And_Controls,
  And_jni, zbarcodescannerview;
  
type

  { TRechargModule }

  TRechargModule = class(jForm)
    jbCall99: jButton;
    jbCallAnon: jButton;
    jbOK: jButton;
    jbScan: jButton;
    jCustomDialog1: jCustomDialog;
    jetCard: jEditText;
    jPanel1: jPanel;
    jZBarcodeScannerView1: jZBarcodeScannerView;
    procedure jbOKClick(Sender: TObject);
    procedure jbScanClick(Sender: TObject);
    procedure jCustomDialog1BackKeyPressed(Sender: TObject; title: string);
    procedure jCustomDialog1Show(Sender: TObject; dialog: jObject; title: string
      );
    procedure jetCardChange(Sender: TObject; txt: string; count: integer);
    procedure jZBarcodeScannerView1Click(Sender: TObject);
    procedure jZBarcodeScannerView1ScannerResult(Sender: TObject;
      codedata: string; codeformat: TBarcodeFormat);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  RechargModule: TRechargModule;

implementation

uses
  unit1;
  
{$R *.lfm}

{ TRechargModule }

procedure TRechargModule.jbOKClick(Sender: TObject);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    if jetCard.Text.Length=16 then
      MainModule.jPhoneCall(self.UriEncode('*662*'+jetCard.Text+'#'));
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);
end;

procedure TRechargModule.jbScanClick(Sender: TObject);
begin
  if IsRuntimePermissionGranted('android.permission.CAMERA') then
  begin
     jZBarcodeScannerView1.Scan();
     jbOk.Visible:=false;
     jetCard.Visible:=false;
     jbScan.Visible:=false;
  end
  else
    Self.RequestRuntimePermission('android.permission.CAMERA', 1010);
end;

procedure TRechargModule.jCustomDialog1BackKeyPressed(Sender: TObject;
  title: string);
begin
  jZBarcodeScannerView1.StopScan();
  if gapp.APILevel<=20 then
  begin
    MainModule.flotar;
  end;
end;

procedure TRechargModule.jCustomDialog1Show(Sender: TObject; dialog: jObject;
  title: string);
begin
  jbOk.Visible:=true;
  jetCard.Visible:=true;
  jbScan.Visible:=true;
end;

procedure TRechargModule.jetCardChange(Sender: TObject; txt: string;
  count: integer);
begin

end;

procedure TRechargModule.jZBarcodeScannerView1Click(Sender: TObject);
begin
  if jZBarcodeScannerView1.FlashlightMode=fmOFF then
    jZBarcodeScannerView1.FlashlightMode:=fmON
  else
    jZBarcodeScannerView1.FlashlightMode:=fmOFF;
end;

procedure TRechargModule.jZBarcodeScannerView1ScannerResult(Sender: TObject;
  codedata: string; codeformat: TBarcodeFormat);
begin
  jZBarcodeScannerView1.StopScan();
  jCustomDialog1.Close();
  jCustomDialog1.Show();
  ShowMessage(codedata);
  if Length(codedata)=16 then
  begin
    RechargModule.jetCard.Text:=codedata;
  end
  else
    ShowMessage('Codigo de recarga invalido');
end;
  

end.
