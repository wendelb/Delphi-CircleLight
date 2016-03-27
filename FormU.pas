unit FormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.GraphUtil, Vcl.ExtCtrls, Math,
  System.Generics.Collections;

type
  TFrmCircleLight = class(TForm)
    Timer: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    Image: TBitmap;
    CenterH: Integer;
    CenterV: Integer;
    phi: Single;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmCircleLight: TFrmCircleLight;
  timerFreq: Int64;

const
  // Settings for the Dot
  DotSize = 80 div 2;
  DotCount = 3;
  DotWinkel = 360.0 / DotCount;
  AbstandMitte = 150;

  // Settings for the shadows
  ShadowCount = 7;
  ShadowWinkel = 7;

  // Speed
  DeltaPhi = 2.0;

implementation

{$R *.dfm}

/// <summary>
/// Set color of Pen & Brush
/// </summary>
procedure SetColor(Bmp: TBitmap; color: TColor);
begin
  Bmp.Canvas.Brush.color := color;
  Bmp.Canvas.Pen.color := color;
end;

procedure TFrmCircleLight.FormCreate(Sender: TObject);
begin
  // Init form
  Self.SetBounds(0, 0, Monitor.Width, Monitor.Height);

  CenterH := Monitor.Width div 2;
  CenterV := Monitor.Height div 2;

  // Init Image
  Image := TBitmap.Create;
  Image.SetSize(Monitor.Width, Monitor.Height);

  // Paint some Background
  Image.Canvas.Brush.color := clBlack;
  Image.Canvas.Rectangle(0, 0, Image.Width, Image.Height);

  // Paint the Image to the Form
  Self.Canvas.Draw(0, 0, Image);

  // Set color for Font
  Self.Canvas.Font.color := clWhite;
  Self.Canvas.Brush.color := clBlack;
end;

procedure TFrmCircleLight.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Close the application on Escape
  if (Shift = []) and (Key = VK_ESCAPE) then
    Close;
end;

procedure TFrmCircleLight.TimerTimer(Sender: TObject);
var
  start, ende: Int64;
  dots, shadows: Integer;
  x, y: Integer;
begin
  QueryPerformanceCounter(start);

  phi := phi + DeltaPhi;
  if (phi > 360.0) then
  begin
    phi := phi - 360.0;
  end;

  SetColor(Image, clBlack);
  Image.Canvas.Rectangle(0, 0, Image.Width, Image.Height);

  for dots := 0 to DotCount - 1 do
  begin
    for shadows := 0 to ShadowCount do
    begin
      SetColor(Image, ColorAdjustLuma(clRed, (ShadowCount - shadows) *
        -10, false));
      x := Trunc(cos(DegToRad(phi + dots * DotWinkel + shadows * ShadowWinkel))
        * AbstandMitte + CenterH);
      y := Trunc(sin(DegToRad(phi + dots * DotWinkel + shadows * ShadowWinkel))
        * AbstandMitte + CenterV);

      Image.Canvas.Ellipse(x - DotSize, y - DotSize, x + DotSize, y + DotSize);
    end;
  end;

  Self.Canvas.Draw(0, 0, Image);

  QueryPerformanceCounter(ende);
  Self.Canvas.TextOut(10, 10, Format('Duration: %1.2f ms',
    [((ende - start) / timerFreq * 1000)]));
end;

initialization

QueryPerformanceFrequency(timerFreq);

end.
