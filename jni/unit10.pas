{Hint: save all files to location: \jni }
unit unit10;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, srecyclerview, Laz_And_Controls;
  
type

  { TAndroidModule8 }

  TAndroidModule8 = class(jForm)
    jImageView1: jImageView;
    jPanel1: jPanel;
    jsRecyclerView1: jsRecyclerView;
    jTextView1: jTextView;
    jTextView2: jTextView;
    jTextView3: jTextView;
    procedure AndroidModule8JNIPrompt(Sender: TObject);
    procedure jsRecyclerView1ItemClick(Sender: TObject; itemPosition: integer);
  private
    {private declarations}
  public
    {public declarations}
  end;

var
  AndroidModule8: TAndroidModule8;

implementation

uses
  unit1, unit7, unit14;
  
{$R *.lfm}
  

{ TAndroidModule8 }

procedure TAndroidModule8.AndroidModule8JNIPrompt(Sender: TObject);
begin
  jsRecyclerView1.SetItemContentLayout(jPanel1.View, True);
  jsRecyclerView1.ClearItemContentFormat;
  jsRecyclerView1.SetItemsRound(10);
  jsRecyclerView1.SetItemContentFormat('text|text|text');
  //http://fontawesome.com/cheatsheet
  jTextView3.SetFontFromAssets('fa-solid-900.ttf');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf53d;')+'|Recargar|Recargar saldo usando tarjetas');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xe068;')+'|Transferir|Transfiere tu saldo a alguien');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf51e;')+'|Adelanto de $25 CUP|Pide adelanto de $25 CUP de saldo');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf51e;')+'|Adelanto de $50 CUP|Pide adelanto de $50 CUP de saldo');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf205;')+'|Activar tarifa por consumo|Usa el saldo para internet');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf204;')+'|Desactivar tarifa por consumo|No usar el saldo para internet');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf023;')+'|Cambiar clave|Cambiar clave para trasnferir saldo');
  jsRecyclerView1.Add(Self.ParseHtmlFontAwesome('&#xf104;')+'|< Atrás|Volver atrás');
end;

procedure TAndroidModule8.jsRecyclerView1ItemClick(Sender: TObject;
  itemPosition: integer);
begin
  if IsRuntimePermissionGranted('android.permission.CALL_PHONE') then
  begin
    case itemposition of
    0://Recargar
      begin
        if gapp.APILevel<=20 then
        begin
          if flotando then
          begin
            MainModule.jwmBubble.RemoveView();
            flotando:=false;
          end;
        end;
        RechargModule.jCustomDialog1.Show('Recargar');
      end;
    1://Tranferir
      begin
        if gapp.APILevel<=20 then
        begin
          if flotando then
          begin
            MainModule.jwmBubble.RemoveView();
            flotando:=false;
          end;
        end;
        TranferModule.worktype:='tranfer';
        TranferModule.jbOK.Text:='TRANSFERIR';
        TranferModule.jbContact.Visible:=true;
        TranferModule.jetAmount.Visible:=true;
        TranferModule.jetPhone.Visible:=true;
        TranferModule.jetPhone.MaxtextLength:=8;
        TranferModule.jetPass.MaxtextLength:=4;
        TranferModule.jetAmount.MaxTextLength:=-1;
        TranferModule.jetPass.Hint:='CLAVE';
        TranferModule.jetPhone.Hint:='TELEFONO';
        TranferModule.jetAmount.Hint:='CANTIDAD';
        TranferModule.jetPass.InputTypeEx:=itxNumberPassword;
        TranferModule.jetAmount.InputTypeEx:=itxCurrency;
        TranferModule.jCustomDialog1.Show('TRANSFERIR SALDO');
      end;
    2://Adelanto 25 CUP
      begin
        MainModule.jPhoneCall(self.UriEncode('*234*3*1*1#'));
      end;
    3://Adelanto 50 CUP
      begin
        MainModule.jPhoneCall(self.UriEncode('*234*3*1*2#'));
      end;
    4://Activar tarifa por consumo
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*1*1#'));
      end;
    5://Desactivar tarifa por consumo
      begin
        MainModule.jPhoneCall(self.UriEncode('*133*1*1*2#'));
      end;
    6://Cambiar clave de tranferencia
      begin
        if gapp.APILevel<=20 then
        begin
          if flotando then
          begin
            MainModule.jwmBubble.RemoveView();
            flotando:=false;
          end;
        end;
        TranferModule.worktype:='changepass';
        TranferModule.jbOK.Text:='CAMBIAR CLAVE';
        TranferModule.jbContact.Visible:=false;
        TranferModule.jetPhone.Visible:=false;
        TranferModule.jetAmount.Hint:='CLAVE ANTERIOR';
        TranferModule.jetPass.Hint:='CLAVE NUEVA';
        TranferModule.jetAmount.MaxTextLength:=4;
        TranferModule.jetPass.MaxtextLength:=4;
        TranferModule.jetPass.InputTypeEx:=itxNumberPassword;
        TranferModule.jetAmount.InputTypeEx:=itxNumberPassword;
        TranferModule.jCustomDialog1.Show('CAMBIAR CLAVE');
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
