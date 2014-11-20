unit SettingsTestGroupsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, LKSL_Settings_Groups,
  LKSL_Settings_Fields;

type

  { TSettingsTestGroups }

  TSettingsTestGroups= class(TTestCase)
  private
    FGroups: TLKSettingsGroups;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGroupsCount;
    procedure TestGroupsClear;
  end;

implementation

procedure TSettingsTestGroups.SetUp;
begin
  FGroups:= TLKSettingsGroups.Create(nil);
end;

procedure TSettingsTestGroups.TearDown;
begin
  FGroups.Free;
end;

procedure TSettingsTestGroups.TestGroupsCount;
var
  Group: TLKSettingsGroup;
begin
  Group:= TLKSettingsGroup.Create(FGroups);
  FGroups.Add(Group);
  AssertEquals('Number of groups in list', 1 , FGroups.Count);
end;

procedure TSettingsTestGroups.TestGroupsClear;
var
  Group: TLKSettingsGroup;
begin
  Group:= TLKSettingsGroup.Create(FGroups);
  FGroups.Add(Group);
  AssertEquals('Inserted groups in list', 1 , FGroups.Count);
  FGroups.Clear;
  AssertEquals('Cleared number of Groups in list', 0 , FGroups.Count);
end;



initialization
  RegisterTest(TSettingsTestGroups);
end.

