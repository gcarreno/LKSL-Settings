{
  LaKraven Studios Standard Library [LKSL]
  Copyright (c) 2014, LaKraven Studios Ltd, All Rights Reserved

  Original Source Location: https://github.com/LaKraven/LKSL

  License:
    - You may use this library as you see fit, including use within commercial applications.
    - You may modify this library to suit your needs, without the requirement of distributing
      modified versions.
    - You may redistribute this library (in part or whole) individually, or as part of any
      other works.
    - You must NOT charge a fee for the distribution of this library (compiled or in its
      source form). It MUST be distributed freely.
    - This license and the surrounding comment block MUST remain in place on all copies and
      modified versions of this source code.
    - Modified versions of this source MUST be clearly marked, including the name of the
      person(s) and/or organization(s) responsible for the changes, and a SEPARATE "changelog"
      detailing all additions/deletions/modifications made.

  Disclaimer:
    - Your use of this source constitutes your understanding and acceptance of this
      disclaimer.
    - LaKraven Studios Ltd and its employees (including but not limited to directors,
      programmers and clerical staff) cannot be held liable for your use of this source
      code. This includes any losses and/or damages resulting from your use of this source
      code, be they physical, financial, or psychological.
    - There is no warranty or guarantee (implicit or otherwise) provided with this source
      code. It is provided on an "AS-IS" basis.

  Donations:
    - While not mandatory, contributions are always appreciated. They help keep the coffee
      flowing during the long hours invested in this and all other Open Source projects we
      produce.
    - Donations can be made via PayPal to PayPal [at] LaKraven (dot) Com
                                          ^  Garbled to prevent spam!  ^
}
unit LKSL_Settings_Fields;

{
  About this unit: (FPC/Lazarus)
    - This unit provides the objects that contain key/value pairs.

  Changelog (newest on top):
    3rd October 2014:
      - Initial Scaffolding
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  {
    TLKSettingsFieldTypes
      - Enum of field types
  }

  TLKSettingsFieldTypes = (
    sftUnknown,
    sftInteger,
    sftString
  );

  {
    TLKSettingsField
      - This is the base class for key/value pair.
  }

  PLKSettingsField = ^TLKSettingsField;
  TLKSettingsField = class(TComponent)
  private
  protected
    FFieldType: TLKSettingsFieldTypes;
    FFieldName: String;
    FDisplayName: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property FieldType: TLKSettingsFieldTypes read FFieldType;
    property FieldName: String read FFieldName write FFieldName;
    property DisplayName: String read FDisplayName write FDisplayName;
  end;

  TLKSettingsFieldClass = class of TLKSettingsField;

  {
    TLKSettingsFieldInteger
      - Class implementing and Integer field.
  }

  TLKSettingsFieldInteger = class(TLKSettingsField)
  private
    FFieldValue: Integer;
    procedure SetValue(AValue: Integer);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Value: Integer read FFieldValue write SetValue;
  end;

  TLKSettingsFieldIntegerClass = class of TLKSettingsFieldInteger;

  {
    TLKSettingsFieldString
      - Class implementing and Integer field.
  }

  TLKSettingsFieldString = class(TLKSettingsField)
  private
    FFieldValue: String;
    procedure SetValue(AValue: String);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Value: String read FFieldValue write SetValue;
  end;

  TLKSettingsFieldStringClass = class of TLKSettingsFieldString;

  {
    TLKSettingsFields
      - This class implements a list of fields
  }

  TLKSettingsFields = class(TComponent)
  private
    FSettingsFieldItems: TFPList;
    function GetCount: Integer;
    function GetSettingsField(Index: Integer): TLKSettingsField;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Add(AField: TLKSettingsField): Integer;
    procedure Delete(AField: TLKSettingsField);
    procedure Delete(AIndex: Integer); overload;
    procedure Clear;

    property Items[Index: Integer]: TLKSettingsField read GetSettingsField; default;
    property Count: Integer read GetCount;
  published
  end;

  {$IFDEF FPC}
  {
    TLKSettingsFieldsEnumerator
      - Enumeration class for field list
  }

  TLKSettingsFieldsEnumerator = class
  private
    FList: TLKSettingsFields;
    FPosition: Integer;
  public
    constructor Create(ASettingsFields: TLKSettingsFields);

    function GetCurrent: TLKSettingsField;
    function MoveNext: Boolean;
    property Current: TLKSettingsField read GetCurrent;
  end;

  {$IFEND}

implementation

{$IFDEF FPC}
{ TLKSettingsFieldsEnumerator }

constructor TLKSettingsFieldsEnumerator.Create(ASettingsFields: TLKSettingsFields);
begin
  FList:= ASettingsFields;
  FPosition:= -1;
end;

function TLKSettingsFieldsEnumerator.GetCurrent: TLKSettingsField;
begin
  Result:= FList[FPosition];
end;

function TLKSettingsFieldsEnumerator.MoveNext: Boolean;
begin
  Inc(FPosition);
  Result:= FPosition < FList.Count;
end;
{$IFEND}

{ TLKSettingsFieldString }

procedure TLKSettingsFieldString.SetValue(AValue: String);
begin
  if FFieldValue <> AValue then
  begin
    FFieldValue:=AValue;
  end;
end;

constructor TLKSettingsFieldString.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFieldType:= sftString;
  FFieldValue:= ''; // TODO: Should I initilize it?
end;

destructor TLKSettingsFieldString.Destroy;
begin
  inherited Destroy;
end;

{ TLKSettingsFields }

function TLKSettingsFields.GetSettingsField(Index: Integer): TLKSettingsField;
begin
  Result:= TLKSettingsField(FSettingsFieldItems[Index]);
end;

function TLKSettingsFields.GetCount: Integer;
begin
  Result:= FSettingsFieldItems.Count;
end;

constructor TLKSettingsFields.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSettingsFieldItems:= TFPList.Create;
end;

destructor TLKSettingsFields.Destroy;
var
  Index: Integer;
begin
  if Assigned(FSettingsFieldItems) then
  begin
      for Index:= FSettingsFieldItems.Count - 1 downto 0 do
      begin
        if Assigned(FSettingsFieldItems[Index]) then
        begin
          TLKSettingsField(FSettingsFieldItems[Index]).Free;
          FSettingsFieldItems.Delete(Index);
        end;
      end;
      FSettingsFieldItems.Free;
  end;
  inherited Destroy;
end;

function TLKSettingsFields.Add(AField: TLKSettingsField): Integer;
begin
  Result:= FSettingsFieldItems.Add(AField);
end;

procedure TLKSettingsFields.Delete(AField: TLKSettingsField);
var
  Index: Integer;
begin
  for Index:= 0 to FSettingsFieldItems.Count - 1 do
  begin
    if AField = TLKSettingsField(FSettingsFieldItems[Index]) then
    begin
      TLKSettingsField(FSettingsFieldItems[Index]).Free;
      FSettingsFieldItems.Delete(Index);
      break;
    end;
  end;
end;

procedure TLKSettingsFields.Delete(AIndex: Integer);
begin
  FSettingsFieldItems.Delete(AIndex);
end;

procedure TLKSettingsFields.Clear;
var
  Index: Integer;
begin
  for Index:= FSettingsFieldItems.Count - 1 downto 0 do
  begin
    if Assigned(FSettingsFieldItems[Index]) then
    begin
      TLKSettingsField(FSettingsFieldItems[Index]).Free;
    end;
    FSettingsFieldItems.Delete(Index);
  end;
end;

{ TLKSettingsField }

constructor TLKSettingsField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFieldType:= sftUnknown;
end;

destructor TLKSettingsField.Destroy;
begin
  inherited Destroy;
end;

{ TLKSettingsFieldInteger }

procedure TLKSettingsFieldInteger.SetValue(AValue: Integer);
begin
  if FFieldValue <> AValue then
  begin
    FFieldValue:=AValue;
  end;
end;

constructor TLKSettingsFieldInteger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFieldType:= sftInteger;
  FFieldValue:= 0; // TODO: Should I initilize it?
end;

destructor TLKSettingsFieldInteger.Destroy;
begin
  inherited Destroy;
end;

end.

