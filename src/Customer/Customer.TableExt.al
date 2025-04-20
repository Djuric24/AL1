tableextension 65400 "MNB Customer" extends Customer
{
    fields
    {
        field(65400; "MNB Bonuses"; Integer)
        {
            Caption = 'Bonuses';
            FieldClass = FlowField;
            CalcFormula = count("MNB Bonus Header" where("Customer No." = field("No.")));
            Editable = false;
        }
    }
    trigger OnBeforeDelete()
    begin
        TestBonusExists();
    end;

    var
        AtLeastOneBonusForCustomerExistsErr: Label 'At least one bonus for customer %1 exists.', Comment = '%1 - customer name';

    local procedure TestIfBonusExists()

    // keys
    // {
    //     // Add changes to keys here
    // }

    // fieldgroups
    // {
    //     // Add changes to field groups here
    // }

    // var
    //     myInt: Integer;
}