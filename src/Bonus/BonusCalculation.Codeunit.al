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
        BonusHeader.SetRange("Customer No.", SalesInvLine."Bill-to Customer No.");
        BonusHeader.SetRange(Status, BonusHeader.Status::Released);
        BonusHeader.SetFilter("Starting Date", '..%1', SalesInvLine."Posting Date");
        BonusHeader.SetFilter("Ending Date", '%1..', SalesInvLine."Posting Date");
        if BonusHeader.FindSet() then
            repeat
                FindBonusForAllItems(BonusHeader, SalesInvLine);
                FindBonusForOneItem(BonusHeader, SalesInvLine);
            until BonusHeader.Next() = 0;
    end;

    local procedure FindBonusForAllItems(var BonusHeader: Record "MNB Bonus Header"; var SalesInvLine: Record "Sales Invoice Line")
    var
        BonusLine: Record "MNB Bonus Line";
    begin
        BonusLine.SetRange("Document No.", BonusHeader."No.");
        BonusLine.SetRange(Type, BonusLine.Type::"All Items");
        if BonusLine.FindFirst() then
            InsertBonusEntry(BonusLine, SalesInvLine);
    end;

    local procedure FindBonusForOneItem(var BonusHeader: Record "MNB Bonus Header"; var SalesInvLine: Record "Sales Invoice Line");
    var
        BonusLine: Record "MNB Bonus Line";
    begin
        BonusLine.SetRange("Document No.", BonusHeader."No.");
        BonusLine.SetRange(Type, BonusLine.Type::Item);
        BonusLine.SetRange("Item No.", SalesInvLine."No.");
        if BonusLine.FindFirst() then
            InsertBonusEntry(BonusLine, SalesInvLine);
    end;

}

