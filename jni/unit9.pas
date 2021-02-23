{Hint: save all files to location: \jni }
unit unit9;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, srecyclerview, Laz_And_Controls;
  
type

  { TAndroidModule7 }

  TAndroidModule7 = class(jForm)
    jImageView1: jImageView;
    jPanel1: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    procedure AndroidModule7JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule7: TAndroidModule7;

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TAndroidModule7 }

procedure TAndroidModule7.AndroidModule7JNIPrompt(Sender: TObject);
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, True);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf674;')+'|Bolsa Correo - $25 CUP|50 MB solo para correo nauta');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf1c0;')+'|Bolsa Diaria [LTE] - $25 CUP| 200 MB (LTE) (24 horas)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|400MB - $125 CUP|+500MB [LTE] +300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|600MB - $175 CUP|+800MB [LTE] +300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|1GB - $250 CUP|+1.5GB [LTE] +300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|2.5GB - $500 CUP|+3GB [LTE] +300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|4GB - $750 CUP|+5GB [LTE] +300MB (CU)');

  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf1c0;')+'|1GB [LTE] - $100 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf1c0;')+'|2.5GB [LTE] - $200 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf1c0;')+'|14GB [LTE] - $1125 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf104;')+'|< Atrás|Volver atrás');
end;

procedure TAndroidModule7.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Bolsa de correo
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*2#'));
      end;
    1://Bolsa diaria
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*3#'));
      end;
    2://400MB + 500MB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*4*1#'));
      end;
    3://600MB + 800MB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*4*2#'));
      end;
    4://1GB + 1.5GB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*4*3#'));
      end;
    5://2GB + 3GB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*4*4#'));
      end;
    6://4GB + 5GB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*4*5#'));
      end;
    7://1GB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*5*1#'));
      end;
    8://2.5GB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*5*2#'));
      end;
    9://14GB lte
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*5*3#'));
      end;
    10://Volver atras
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
