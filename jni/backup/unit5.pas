{Hint: save all files to location: \jni }
unit unit5;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, srecyclerview;
  
type

  { TAndroidModule5 }

  TAndroidModule5 = class(jForm)
    jImageView1: jImageView;
    jPanel1: jPanel;
    jPanel2: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    procedure AndroidModule5JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
    procedure refillitems;
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule5: TAndroidModule5;

implementation

uses
  unit1,unit7,unit8;
  
{$R *.lfm}
  

{ TAndroidModule5 }

procedure TAndroidModule5.refillitems;
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, true);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  //http://fontawesome.com/cheatsheet
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf155;')+'|Saldo|Consulta tu saldo');
  jsRecyclerView1.SetItemTag(0,'*222#');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf06b;')+'|Bono|Consulta tu bono');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf57d;')+'|Datos|Consulta tus megas');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf879;')+'|Gestionar llamadas|Llamadas especiales');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf4c0;')+'|Gestionar saldo >|Transfiere, recarga o pide prestado');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf1c0;')+'|Paquetes líneas USIM >|Para líneas nuevas con 4G');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf1c0;')+'|Paquetes líneas SIM  >|Para líneas antiguas sin 4G');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf2a0;')+'|Plan de voz >|Compra paquetes de voz');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf651;')+'|Plan de sms >|Compra paquetes de sms');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf500;')+'|Plan amigos >|Gestiona tu plan amigos');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf64a;')+'|Corporativos|Consulta el plan corporativo');
end;

procedure TAndroidModule5.AndroidModule5JNIPrompt(Sender: TObject);
begin
  refillitems;
end;

procedure TAndroidModule5.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
var
  nt:string;
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Saldo
      begin
        MainModule.jPhoneCall(self.UriEncode(jsRecyclerView1.GetItemTag(itemPosition)));
        //MainModule.jTelephonyManager1.Call(self.UriEncode('*222#'));
      end;
    1://Bono
      begin
        MainModule.jPhoneCall(self.UriEncode('*222*266#'));
      end;
    2://Datos
      begin
        MainModule.jPhoneCall(self.UriEncode('*222*328#'));
      end;
    3://Llamar especial
      begin
        if gapp.APILevel<=20 then
        begin
          if flotando then
          begin
            MainModule.jwmBubble.RemoveView();
            flotando:=false;
          end;
        end;
        CallModule.jCustomDialog1.Show('Llamar');
      end;
    4://Gestionar saldo
      begin
        MainModule.jsViewPager2.SetPosition(1);
      end;
    5://Paquetes de datos USIM
      begin
        //nt:=MainModule.jTelephonyManager1.GetNetworkType();
        //ShowMessage(nt);
        //ShowMessage(MainModule.jTelephonyManager1.GetSimCountryIso());
        //if (nt='UMTS') or (nt='LTE') then
          MainModule.jsViewPager2.SetPosition(3)
        //else
          //MainModule.jsViewPager2.SetPosition(2);
      end;
    6://Paquetes de datos SIM
      begin
        MainModule.jsViewPager2.SetPosition(2);
      end;
    7://Plan de voz
      begin
        MainModule.jsViewPager2.SetPosition(4);
      end;
    8://Plan de sms
      begin
        MainModule.jsViewPager2.SetPosition(5);
      end;
    9://Plan amigos
      begin
        MainModule.jsViewPager2.SetPosition(6);
      end;
    10://Saldos Corporativos
      begin
        MainModule.jPhoneCall(self.UriEncode('*111#'));
      end;
    else
      gApp.ShowMessage('Burbuja de datos','Funcion no implementada','Ok');
    end;
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);

end;

end.
