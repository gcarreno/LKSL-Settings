unit frmMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    GroupBox1: TGroupBox;
    gbGroups: TGroupBox;
    lbGroups: TListBox;
    panGroups: TPanel;
    panKeyValue: TPanel;
    Splitter1: TSplitter;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

end.

