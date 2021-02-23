{Hint: save all files to location: \jni }
unit unit12;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, srecyclerview, Laz_And_Controls;
  
type

  { TAndroidModule10 }

  TAndroidModule10 = class(jForm)
    jImageView1: jImageView;
    jImageView2: jImageView;
    jPanel1: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    jTextView4: jTextView;
    jTextView5: jTextView;
    jTextView6: jTextView;
    procedure AndroidModule10JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule10: TAndroidModule10;

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TAndroidModule10 }

procedure TAndroidModule10.AndroidModule10JNIPrompt(Sender: TObject);
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, True);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf651;')+'|Saldo de sms|Consultar plan sms');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7f5')+'|10 SMS - $17.50 CUP|10 SMS ($1.75 CUP por SMS)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7f5')+'|20 SMS - $32,50 CUP|15 SMS ($1,63 CUP por SMS)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7f5')+'|35 SMS - $52.50 CUP|35 SMS ($1.50 CUP por SMS)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7f5')+'|45 SMS - $62,50 CUP|45 SMS ($1.39 CUP por SMS)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf104;')+'|< Atrás|Volver atrás');
end;

procedure TAndroidModule10.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Saldo sms
      begin
        MainModule.jPhoneCall(self.UriEncode('*222*767#'));
      end;
    1://10 sms
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*2*1#'));
      end;
    2://20 sms
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*2*2#'));
      end;
    3://35 sms
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*2*3#'));
      end;
    4://45 sms
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*2*4#'));
      end;
    5://Volver atras
      begin
        MainModule.jsViewPager2.SetPosition(0);
      end;
    else
      gApp.ShowMessage('Burbuja de datos','Funcion no implementada','Ok');
    end;
  end
  else
    Self.RequestRuntimePermission('android.permission.CALL_PHONE', 1009);
end;


end.
