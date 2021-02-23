{Hint: save all files to location: \jni }
unit unit11;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, srecyclerview, Laz_And_Controls;
  
type

  { TAndroidModule9 }

  TAndroidModule9 = class(jForm)
    jImageView1: jImageView;
    jPanel1: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    procedure AndroidModule9JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule9: TAndroidModule9;

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TAndroidModule9 }

procedure TAndroidModule9.AndroidModule9JNIPrompt(Sender: TObject);
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, True);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf2a0;')+'|Saldo de minutos|Consultar plan de voz');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf017;')+'|5 MIN - $37.50 CUP|5 min de voz ($7.50 CUP por min)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf017;')+'|10 MIN - $72.50 CUP|10 min de voz ($7.25 CUP por min)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf017;')+'|15 MIN - $105 CUP|15 min de voz ($7 CUP por min)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf017;')+'|25 MIN - $162.50 CUP|25 min de voz ($6.50 CUP por min)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf017;')+'|40 MIN - $250 CUP|40 min de voz ($6.25 CUP por min)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf104;')+'|< Atrás|Volver atrás');
end;

procedure TAndroidModule9.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Saldo de minutos
      begin
        MainModule.jPhoneCall(self.UriEncode('*222*869#'));
      end;
    1://5 min
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*3*1#'));
      end;
    2://10 min
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*3*2#'));
      end;
    3://15 min
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*3*3#'));
      end;
    4://25 min
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*3*4#'));
      end;
    5://40 min
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*3*5#'));
      end;
    6://Volver atras
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
