{Hint: save all files to location: \jni }
unit unit13;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, srecyclerview, Laz_And_Controls;
  
type

  { TAndroidModule11 }

  TAndroidModule11 = class(jForm)
    jImageView1: jImageView;
    jPanel1: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    procedure AndroidModule11JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule11: TAndroidModule11;

implementation

uses
  unit1,unit15;
  
{$R *.lfm}
  

{ TAndroidModule11 }

procedure TAndroidModule11.AndroidModule11JNIPrompt(Sender: TObject);
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, True);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf500;')+'|Estado|Consultar plan amigos');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf0c0;')+'|Activar|Activa el plan');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xe073;')+'|Desactivar|Desactiva el plan');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf234;')+'|Agregar amigo|Agrega el número de un amigo');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf503;')+'|Eliminar amigo|Elimina el número de un amigo');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf507;')+'|Lista de amigos|Consulta tu lista de numeros amigos');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf104;')+'|< Atrás|Volver atrás');
end;

procedure TAndroidModule11.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Estado
      begin
        MainModule.jPhoneCall(self.UriEncode('*222*264#'));
      end;
    1://Activar plan amigo
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*4*1*1#'));
      end;
    2://Desactivar plan amigo
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*4*1*2#'));
      end;
    3://Agregar amigo
      begin
        if gapp.APILevel<=20 then
        begin
          if flotando then
          begin
            MainModule.jwmBubble.RemoveView();
            flotando:=false;
          end;
        end;
        FriendModule.jbOK.Text:='Agregar';
        FriendModule.jCustomDialog1.Show('Agregar amigo');
      end;
    4://Eliminar amigo
      begin
        if gapp.APILevel<=20 then
        begin
          if flotando then
          begin
            MainModule.jwmBubble.RemoveView();
            flotando:=false;
          end;
        end;
        FriendModule.jbOK.Text:='Eliminar';
        FriendModule.jCustomDialog1.Show('Eliminar amigo');
      end;
    5://lista amigos
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*4*3#'));
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
