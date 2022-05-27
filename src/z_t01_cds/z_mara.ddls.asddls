@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Entity root view to the table MARA'
@UI: {
 headerInfo: { typeName: 'Material', typeNamePlural: 'Materialien', title: { type: #STANDARD, value: 'Matnr' } } }

@Search.searchable: true
define root view entity Z_MARA as select from mara {
    @Search.defaultSearchElement: true
    key matnr as Matnr,
    @UI: {
          lineItem:       [ { position: 30, importance: #MEDIUM } ],
          identification: [ { position: 30 } ] }
    ersda as Ersda,
    created_at_time as CreatedAtTime,
    ernam as Ernam,
    laeda as Laeda,
    aenam as Aenam,
    vpsta as Vpsta,
    pstat as Pstat,
    lvorm as Lvorm,
    mtart as Mtart,
    mbrsh as Mbrsh,
    matkl as Matkl,
    bismt as Bismt,
    meins as Meins,
    bstme as Bstme,
    zeinr as Zeinr,
    zeiar as Zeiar,
    zeivr as Zeivr,
    zeifo as Zeifo,
    aeszn as Aeszn,
    blatt as Blatt,
    blanz as Blanz,
    ferth as Ferth,
    formt as Formt,
    groes as Groes,
    wrkst as Wrkst,
    normt as Normt,
    labor as Labor,
    ekwsl as Ekwsl,
    brgew as Brgew,
    ntgew as Ntgew,
    gewei as Gewei,
    volum as Volum,
    voleh as Voleh,
    behvo as Behvo,
    raube as Raube,
    tempb as Tempb,
    disst as Disst,
    tragr as Tragr,
    stoff as Stoff
}
