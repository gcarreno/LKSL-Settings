program settingstest;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, SettingsTestGroupsUnit,
  SettingsTestFieldsUnit;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

