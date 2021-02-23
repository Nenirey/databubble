{Hint: save all files to location: \jni }
unit unit6;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, srecyclerview, Laz_And_Controls, videoview;
  
type

  { TAndroidModule6 }

  TAndroidModule6 = class(jForm)
    jImageView1: jImageView;
    jPanel1: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    procedure AndroidModule6JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule6: TAndroidModule6;

implementation

uses
  unit1;
  
{$R *.lfm}
  

{ TAndroidModule6 }

procedure TAndroidModule6.AndroidModule6JNIPrompt(Sender: TObject);
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, True);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf674;')+'|Bolsa Correo - $25 CUP|50 MB solo para correo nauta');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|400 MB - $125 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|600 MB - $175 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|1 GB - $250 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|2.5 GB - $500 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|4 GB - $750 CUP|+300MB (CU)');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf7c4;')+'|Paquetes LTE >|Compra paquetes solo para la red 4G');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf104;')+'|< Atrás|Volver atrás');
end;

procedure TAndroidModule6.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Bolsa de correo
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*2#'));
      end;
    1://400MB
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*3*1#'));
      end;
    2://600MB
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*3*2#'));
      end;
    3://1GB
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*3*3#'));
      end;
    4://2.5GB
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*3*4#'));
      end;
    5://4GB
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*3*5#'));
      end;
    6://Paquetes LTE
      begin
        MainModule.jsViewPager2.SetPosition(3);
      end;
    7://Volver atras
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
