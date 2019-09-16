unit uTimeLine;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.DBCtrls,DateUtils;

type
  TfrmTimeLine = class(TForm)
    tabSuperior: TPanel;
    tabMeio: TPanel;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    DBCtrlGrdTimeLine: TDBCtrlGrid;
    dsTimeline: TDataSource;
    ibqTimeLine: TFDQuery;
    ImageList1: TImageList;
    Button1: TButton;
    DBText1: TDBText;
    Image1: TImage;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    lblNenhum: TLabel;
    procedure DBCtrlGrdTimeLinePaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTimeLine: TfrmTimeLine;

implementation

{$R *.dfm}

uses
  uDM;
procedure TfrmTimeLine.Button1Click(Sender: TObject);
begin
    with ibqTimeLine do
    begin
        Close;
        SQL.Clear;
        SQL.Add('Select * from tbl_Atividade where 1=1 ');

        //Seleciona por período...
        case RadioGroup1.ItemIndex  of
            1:begin
                 SQL.Add(' and ATI_DATA BETWEEN CURRENT_DATE -90 AND CURRENT_DATE ');
              end;
            2:begin
                 SQL.Add(' and ATI_DATA BETWEEN CURRENT_DATE -30 AND CURRENT_DATE ');
              end;
            3:begin
                 SQL.Add(' and ATI_DATA = '+QuotedStr(FormatDateTime('dd.mm.yyyy',now)));
              end;
        end;

        Open;

        if not IsEmpty then
        begin

           DBCtrlGrdTimeLine.Visible:= True;
           DBCtrlGrdTimeLine.RowCount :=  ibqTimeLine.RecordCount;
           DBCtrlGrdTimeLine.PanelHeight := 140;
           lblNenhum.Visible  := not DBCtrlGrdTimeLine.Visible;
        end
        else
        begin
           DBCtrlGrdTimeLine.Visible:= False;
           DBCtrlGrdTimeLine.PanelHeight := 140;
           lblNenhum.Visible  := not DBCtrlGrdTimeLine.Visible;
        end;
    end;
end;

procedure TfrmTimeLine.DBCtrlGrdTimeLinePaintPanel(DBCtrlGrid: TDBCtrlGrid;
  Index: Integer);
begin

     if not dsTimeline.DataSet.IsEmpty then
     begin
         //Altera imagem de acordo com tipo de atividade...
         case dsTimeline.DataSet.FieldByName('ATI_TIPO').AsInteger of
            1: begin
                  ImageList1.GetIcon(0,Image1.Picture.Icon);
                  DBCtrlGrdTimeLine.Canvas.Draw(20,6,Image1.Picture.Graphic);
               end;
            2: begin
                  ImageList1.GetIcon(1,Image1.Picture.Icon);
                  DBCtrlGrdTimeLine.Canvas.Draw(20,6,Image1.Picture.Graphic);
               end;
            3: begin
                  ImageList1.GetIcon(2,Image1.Picture.Icon);
                  DBCtrlGrdTimeLine.Canvas.Draw(20,6,Image1.Picture.Graphic);
               end;
            4: begin
                  ImageList1.GetIcon(3,Image1.Picture.Icon);
                  DBCtrlGrdTimeLine.Canvas.Draw(20,6,Image1.Picture.Graphic);
               end;

         end;
         Image1.Picture.Bitmap := nil;
     end;
end;

end.
