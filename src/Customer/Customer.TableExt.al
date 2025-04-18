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