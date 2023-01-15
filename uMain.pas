//CREATE BY ANDIC


unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation,JSON;

type
  TfrmMain = class(TForm)
    ListBox1: TListBox;
    loData: TLayout;
    lblNama: TLabel;
    lblAlamat: TLabel;
    lblSaldo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    procedure addItem(Nomor: Integer; Nama, Alamat: String; Saldo: Double);
    procedure SetDataToListBox;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  response ='{"data":[{"nomor":"234","nama":"anu","alamat":"Magelang" ,"saldo":"200000"},'+
                     '{"nomor":"345","nama":"ani","alamat":"Jakarta"  ,"saldo":"300000"},'+
                     '{"nomor":"456","nama":"ano","alamat":"Pontianak","saldo":"400000"}]}';
var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.addItem(Nomor:Integer;Nama,Alamat:String;Saldo:Double);
var
 lo : TLayout;
 lb : TListBoxItem;
begin
  lblNama.Text   := Nama;
  lblAlamat.Text := Alamat;
  lblSaldo.Text  := format('%.0n',[Saldo]);

  lb                := TListBoxItem.Create(ListBox1);
  lb.Width          := ListBox1.Width;
  lb.Height         := loData.Height;
  lb.Selectable     := false;
  lb.StyledSettings := [];
  lb.Tag            := Nomor;

  lo            := TLayout(loData.Clone(lb));
  lo.Position.X := 8;
  lo.Position.Y := 0;
  lo.Width      := lb.Width - lo.Position.X*2;
  lo.Visible    := true;

  lb.AddObject(lo);
  ListBox1.AddObject(lb);
end;

procedure TfrmMain.SetDataToListBox;
var
  jv: TJSONValue;
begin
  var jo := TJSONObject.ParseJSONValue(response) AS TJSONObject;
  var ja := jo.GetValue('data') AS TJSONArray;

  for jv in ja do
    addItem(jv.GetValue<Integer>('nomor'),
            jv.GetValue<string>('nama'),
            jv.GetValue<string>('alamat'),
            jv.GetValue<Double>('saldo'));
  ja.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  loData.Visible := false;
  SetDataToListBox;
end;

procedure TfrmMain.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  ShowMessage(Item.Tag.ToString);
end;

end.
