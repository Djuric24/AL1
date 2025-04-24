table 65400 "MNB Bonus Header"
{
    Caption = 'Bonus';
    DataClassification = CustomerContent;
    DrillDownPageId = "MNB Bonus List";
    LookupPageId = "MNB Bonus List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

        }
        field(2; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(3; "Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Date';
            trigger OnValidate()
            begin
                TestStatus();
                if "Ending Date" < "Starting Date" then
                    "Ending Date" := "Starting Date";
            end;
        }
        field(4; "Ending Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ending Date';
            trigger OnValidate()
            begin
                TestStatus();
                if "Ending Date" < "Starting Date" then
                    "Starting Date" := "Ending Date"
            end;
        }
        field(5; Status; Enum "MNB Bonus Header Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    // var
    //     myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        TestStatus();
        DeleteLines();
    end;

    trigger OnRename()
    begin

    end;

    var
        StatusCannotBeReleasedErr: Label 'Status cannot be %1.', Comment = '%1 status field value';

    local procedure TestStatus()
    begin
        if Status = Status::Released then
            Error(StatusCannotBeReleasedErr, Status);
    end;

    local procedure DeleteLines()
    var
        BonusLine: Record "MNB Bonus Line";
    begin
        BonusLine.SetRange("Document No.", "No.");
        BonusLine.DeleteAll();
    end;
}