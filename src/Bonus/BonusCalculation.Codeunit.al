codeunit 65400 "MNB Bonus Calculation"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', true, true)]
    local procedure RunOnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line")
    begin
        CalculateBonus(SalesInvLine);
    end;

    local procedure CalculateBonus(var SalesInvLine: Record "Sales Invoice Line")
    var
        BonusHeader: Record "MNB Bonus Header";
    begin
        if SalesInvLine.Type <> SalesInvLine.Type::Item then
            exit;
    end;
}

