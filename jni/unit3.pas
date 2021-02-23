{Hint: save all files to location: D:\lamw\projects\databubble\jni }
unit unit3;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls,
  Spinner, seekbar, radiogroup;
  
type

  { TAndroidModule3 }

  TAndroidModule3 = class(jForm)
    jchbAllNetworks: jCheckBox;
    jchbAutoStart: jCheckBox;
    jchbBolsaDiaria: jCheckBox;
    jchbBolsaNauta: jCheckBox;
    jchbBonificados: jCheckBox;
    jchbBonoLTE: jCheckBox;
    jchbNacionales: jCheckBox;
    jchbNotification: jCheckBox;
    jchbOnlywData: jCheckBox;
    jchbServiceUSSD: jCheckBox;
    jchbSoloLTE: jCheckBox;
    jchbTime: jCheckBox;
    jchbSaldo: jCheckBox;
    jchbDeuda: jCheckBox;
    jchbBonoSaldo: jCheckBox;
    jchbService: jCheckBox;
    jchbTraffic: jCheckBox;
    jImageView1: jImageView;
    jPPreferences: jPanel;
    jrgFormat: jRadioGroup;
    jScrollView2: jScrollView;
    jsbInterval: jSeekBar;
    jTextView1: jTextView;
    jtvdataformat: jTextView;
    jtvFormat: jTextView;
    jtvInicio: jTextView;
    jtvInterval: jTextView;
    procedure AndroidModule3JNIPrompt(Sender: TObject);
    procedure jchbAllNetworksClick(Sender: TObject);
    procedure jchbAutoStartClick(Sender: TObject);
    procedure jchbBolsaDiariaClick(Sender: TObject);
    procedure jchbBolsaNautaClick(Sender: TObject);
    procedure jchbBonificadosClick(Sender: TObject);
    procedure jchbBonoLTEClick(Sender: TObject);
    procedure jchbBonoSaldoClick(Sender: TObject);
    procedure jchbDeudaClick(Sender: TObject);
    procedure jchbNacionalesClick(Sender: TObject);
    procedure jchbNotificationClick(Sender: TObject);
    procedure jchbOnlywDataClick(Sender: TObject);
    procedure jchbSaldoClick(Sender: TObject);
    procedure jchbServiceClick(Sender: TObject);
    procedure jchbServiceUSSDClick(Sender: TObject);
    procedure jchbSoloLTEClick(Sender: TObject);
    procedure jchbTimeClick(Sender: TObject);
    procedure jchbTrafficClick(Sender: TObject);
    procedure jrgFormatCheckedChanged(Sender: TObject; checkedIndex: integer;
      checkedCaption: string);
    procedure jsbIntervalProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jsbIntervalStartTrackingTouch(Sender: TObject; progress: integer);
    procedure jsbIntervalStopTrackingTouch(Sender: TObject; progress: integer);
    procedure jspIntervalItemSelected(Sender: TObject; itemCaption: string;
      itemIndex: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule3: TAndroidModule3;

implementation
  
{$R *.lfm}
  
uses
  unit1, notificationmanager;
{ TAndroidModule3 }

procedure TAndroidModule3.AndroidModule3JNIPrompt(Sender: TObject);
begin

end;

procedure TAndroidModule3.jchbAllNetworksClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbAutoStartClick(Sender: TObject);
begin
  autostart:=AndroidModule3.jchbAutoStart.Checked;
end;

procedure TAndroidModule3.jchbBolsaDiariaClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbBolsaNautaClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbBonificadosClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbBonoLTEClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbBonoSaldoClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbDeudaClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbNacionalesClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbNotificationClick(Sender: TObject);
begin
  if jchbNotification.Checked=false then
    MainModule.jNotificationManager1.CancelAll()
  else
  begin
    MainModule.jNotificationManager1.SetContentIntent(gapp.PackageName, 'App', 'MyCustomDataName','bubble-start');
    MainModule.jNotificationManager1.AutoCancel:=false;
    MainModule.jNotificationManager1.SetPriority(npMin);
    MainModule.jNotificationManager1.Notify();
  end;
end;

procedure TAndroidModule3.jchbOnlywDataClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbSaldoClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbServiceClick(Sender: TObject);
begin
  MainModule.jPreferences1.SetBoolData('service',AndroidModule3.jchbService.Checked);
  if AndroidModule3.jchbService.Checked and (ifservicerunning=false) then
  begin
    ifservicerunning:=true;
    ShowMessage('Service Running...');
    MainModule.jcToyTimerService1.Start();
    MainModule.jcToyTimerService1.Bind();
    if MainModule.jcToyTimerService1.IsTimerRunning()=false then
    begin
      MainModule.jcToyTimerService1.TimerOn();
      MainModule.jcToyTimerService1.RunForeground();
    end;
  end
  else
  begin
    ifservicerunning:=false;
    if MainModule.jcToyTimerService1.IsTimerRunning() then
      MainModule.jcToyTimerService1.TimerOff();
    MainModule.jcToyTimerService1.UnBind();
    MainModule.jcToyTimerService1.Stop();
  end;
end;

procedure TAndroidModule3.jchbServiceUSSDClick(Sender: TObject);
begin
  ussdserviceenable:=AndroidModule3.jchbServiceUSSD.Checked;
  {if ussdserviceenable then
  begin
    MainModule.jUSSDService1.Start();
    MainModule.jBroadcastReceiver1.RegisterIntentActionFilter('org.lamw.action.USSDService');
  end
  else
  begin
    MainModule.jUSSDService1.Stop();
    MainModule.jBroadcastReceiver1.Unregister();
  end;}
end;

procedure TAndroidModule3.jchbSoloLTEClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbTimeClick(Sender: TObject);
begin
  //MainModule.savepreferences;
end;

procedure TAndroidModule3.jchbTrafficClick(Sender: TObject);
begin
  showtraffic:=AndroidModule3.jchbTraffic.Checked;
  traffictext:='';
end;

procedure TAndroidModule3.jrgFormatCheckedChanged(Sender: TObject;
  checkedIndex: integer; checkedCaption: string);
begin
  digitos:=0-jrgFormat.CheckedIndex;
  if tmprawcontent<>'' then
    MainModule.parsehtmldata(tmprawcontent);
end;

procedure TAndroidModule3.jsbIntervalProgressChanged(Sender: TObject;
  progress: integer; fromUser: boolean);
begin
  if jsbInterval.Progress<10 then
    jtvInterval.FontColor:=colbrRed
  else
    jtvInterval.FontColor:=colbrBlack;
  jtvInterval.Text:='Actualizar cada '+inttostr(progress)+' seg.';
end;

procedure TAndroidModule3.jsbIntervalStartTrackingTouch(Sender: TObject;
  progress: integer);
begin

end;

procedure TAndroidModule3.jsbIntervalStopTrackingTouch(Sender: TObject;
  progress: integer);
begin
  if progress>=5 then
  begin
    MainModule.jTemporizador.Interval:=progress*1000;
    jtvInterval.Text:='Actualizar cada '+inttostr(jsbInterval.Progress)+' seg.';
  end
  else
    jsbInterval.Progress:=5;
end;

procedure TAndroidModule3.jspIntervalItemSelected(Sender: TObject;
  itemCaption: string; itemIndex: integer);
begin
  //MainModule.savepreferences;
  MainModule.jTemporizador.Interval:=strtoint(itemCaption)*1000;
end;

end.
