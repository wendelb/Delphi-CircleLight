program CircleLight;

uses
  Vcl.Forms,
  FormU in 'FormU.pas' {FrmCircleLight};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmCircleLight, FrmCircleLight);
  Application.Run;
end.
