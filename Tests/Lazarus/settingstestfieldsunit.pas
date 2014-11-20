unit SettingsTestFieldsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, LKSL_Settings_Fields;

type

  { TSettingsTestFields }

  TSettingsTestFields= class(TTestCase)
  private
    FFields: TLKSettingsFields;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFieldsCount;
    procedure TestFieldsClear;
    procedure TestFieldIntegerValue;
    procedure TestFieldStringValue;
    procedure TestFieldIntegerType;
    procedure TestFieldStringType;
  end;

implementation

procedure TSettingsTestFields.TestFieldsCount;
var
  FieldInt: TLKSettingsFieldInteger;
begin
  FieldInt:= TLKSettingsFieldInteger.Create(FFields);
  FFields.Add(FieldInt);
  AssertEquals('Number of fields in list.', 1, FFields.Count);
end;

procedure TSettingsTestFields.TestFieldsClear;
var
  FieldInt: TLKSettingsFieldInteger;
  FieldStr: TLKSettingsFieldString;
begin
  FieldInt:= TLKSettingsFieldInteger.Create(FFields);
  FFields.Add(FieldInt);
  FieldStr:= TLKSettingsFieldString.Create(FFields);
  FFields.Add(FieldStr);
  AssertEquals('Inserted fields in list.', 2, FFields.Count);
  FFields.Clear;
  AssertEquals('Cleared Number of fields in list.', 0, FFields.Count);
end;

procedure TSettingsTestFields.TestFieldIntegerValue;
var
  FieldInt: TLKSettingsFieldInteger;
begin
  FieldInt:= TLKSettingsFieldInteger.Create(FFields);
  FieldInt.Value:= 10;
  AssertEquals('Integer field value.', 10, FieldInt.Value);
  FieldInt.Free;
end;

procedure TSettingsTestFields.TestFieldStringValue;
var
  FieldStr: TLKSettingsFieldString;
begin
  FieldStr:= TLKSettingsFieldString.Create(FFields);
  FieldStr.Value:= 'Testing string value';
  AssertEquals('String Field Value.', 'Testing string value', FieldStr.Value);
  FieldStr.Free;
end;

procedure TSettingsTestFields.TestFieldIntegerType;
var
  FieldInt: TLKSettingsFieldInteger;
begin
  FieldInt:= TLKSettingsFieldInteger.Create(FFields);
  AssertTrue('Integer field type.', sftInteger = FieldInt.FieldType);
  FieldInt.Free;
end;

procedure TSettingsTestFields.TestFieldStringType;
var
  FieldStr: TLKSettingsFieldString;
begin
  FieldStr:= TLKSettingsFieldString.Create(FFields);
  AssertTrue('String field type.', sftString = FieldStr.FieldType);
  FieldStr.Free;
end;

procedure TSettingsTestFields.SetUp;
begin
  FFields:= TLKSettingsFields.Create(nil);
end;

procedure TSettingsTestFields.TearDown;
begin
  FFields.Free;
end;

initialization
  RegisterTest(TSettingsTestFields);
end.

