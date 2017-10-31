//
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation

struct RegionViewModel {
    let title: String
    let countryCode: CountryCode
}

class SelectRegionPresenter {

    func navigationTitle() -> String {
        return "Select Region"
    }

    func updateView() -> [RegionViewModel] {
        return [
            RegionViewModel(title: " - ", countryCode: .unknown ),
            RegionViewModel(title: "Australia", countryCode: .AU),
            RegionViewModel(title: "New Zeland", countryCode: .NZ)
        ]
    }
}


/*

 Australia    AU
 Austria    AT
 Belgium    BE
 Croatia    HR
 Denmark    DK
 Finland    FI
 France    FR
 Germany    DE
 Hungary    HU
 Iceland    IS
 India    IN
 Italy    IT
 Liechtenstein    LI
 Luxembourg    LU
 Mexico    MX
 Netherlands    NL
 New Zealand    NZ
 Norway    NO
 Pakistan    PK
 Poland    PL
 Portugal    PT
 San Marino    SM
 Slovakia    SK
 Slovenia    SI
 South Africa    ZA
 Spain    ES
 Sri Lanka    LK
 Switzerland    CH
 Thailand    TH
 United States of America    US



 Czechia    CZ    CZE    203    ISO 3166-2:CZ    Yes


 Afghanistan    AF    AFG    004    ISO 3166-2:AF    Yes
 Åland Islands    AX    ALA    248    ISO 3166-2:AX    No
 Albania    AL    ALB    008    ISO 3166-2:AL    Yes
 Algeria    DZ    DZA    012    ISO 3166-2:DZ    Yes
 American Samoa    AS    ASM    016    ISO 3166-2:AS    No
 Andorra    AD    AND    020    ISO 3166-2:AD    Yes
 Angola    AO    AGO    024    ISO 3166-2:AO    Yes
 Anguilla    AI    AIA    660    ISO 3166-2:AI    No
 Antarctica    AQ    ATA    010    ISO 3166-2:AQ    No
 Antigua and Barbuda    AG    ATG    028    ISO 3166-2:AG    Yes
 Argentina    AR    ARG    032    ISO 3166-2:AR    Yes
 Armenia    AM    ARM    051    ISO 3166-2:AM    Yes
 Aruba    AW    ABW    533    ISO 3166-2:AW    No
 Azerbaijan    AZ    AZE    031    ISO 3166-2:AZ    Yes
 Bahamas    BS    BHS    044    ISO 3166-2:BS    Yes
 Bahrain    BH    BHR    048    ISO 3166-2:BH    Yes
 Bangladesh    BD    BGD    050    ISO 3166-2:BD    Yes
 Barbados    BB    BRB    052    ISO 3166-2:BB    Yes
 Belarus    BY    BLR    112    ISO 3166-2:BY    Yes
 Belize    BZ    BLZ    084    ISO 3166-2:BZ    Yes
 Benin    BJ    BEN    204    ISO 3166-2:BJ    Yes
 Bermuda    BM    BMU    060    ISO 3166-2:BM    No
 Bhutan    BT    BTN    064    ISO 3166-2:BT    Yes
 Bolivia (Plurinational State of)    BO    BOL    068    ISO 3166-2:BO    Yes
 Bonaire, Sint Eustatius and Saba    BQ    BES    535    ISO 3166-2:BQ    No
 Bosnia and Herzegovina    BA    BIH    070    ISO 3166-2:BA    Yes
 Botswana    BW    BWA    072    ISO 3166-2:BW    Yes
 Bouvet Island    BV    BVT    074    ISO 3166-2:BV    No
 Brazil    BR    BRA    076    ISO 3166-2:BR    Yes
 British Indian Ocean Territory    IO    IOT    086    ISO 3166-2:IO    No
 Brunei Darussalam    BN    BRN    096    ISO 3166-2:BN    Yes
 Bulgaria    BG    BGR    100    ISO 3166-2:BG    Yes
 Burkina Faso    BF    BFA    854    ISO 3166-2:BF    Yes
 Burundi    BI    BDI    108    ISO 3166-2:BI    Yes
 Cabo Verde    CV    CPV    132    ISO 3166-2:CV    Yes
 Cambodia    KH    KHM    116    ISO 3166-2:KH    Yes
 Cameroon    CM    CMR    120    ISO 3166-2:CM    Yes
 Canada    CA    CAN    124    ISO 3166-2:CA    Yes
 Cayman Islands    KY    CYM    136    ISO 3166-2:KY    No
 Central African Republic    CF    CAF    140    ISO 3166-2:CF    Yes
 Chad    TD    TCD    148    ISO 3166-2:TD    Yes
 Chile    CL    CHL    152    ISO 3166-2:CL    Yes
 China    CN    CHN    156    ISO 3166-2:CN    Yes
 Christmas Island    CX    CXR    162    ISO 3166-2:CX    No
 Cocos (Keeling) Islands    CC    CCK    166    ISO 3166-2:CC    No
 Colombia    CO    COL    170    ISO 3166-2:CO    Yes
 Comoros    KM    COM    174    ISO 3166-2:KM    Yes
 Congo    CG    COG    178    ISO 3166-2:CG    Yes
 Congo (Democratic Republic of the)    CD    COD    180    ISO 3166-2:CD    Yes
 Cook Islands    CK    COK    184    ISO 3166-2:CK    No
 Costa Rica    CR    CRI    188    ISO 3166-2:CR    Yes
 Côte d'Ivoire    CI    CIV    384    ISO 3166-2:CI    Yes
 Cuba    CU    CUB    192    ISO 3166-2:CU    Yes
 Curaçao    CW    CUW    531    ISO 3166-2:CW    No
 Cyprus    CY    CYP    196    ISO 3166-2:CY    Yes
 Djibouti    DJ    DJI    262    ISO 3166-2:DJ    Yes
 Dominica    DM    DMA    212    ISO 3166-2:DM    Yes
 Dominican Republic    DO    DOM    214    ISO 3166-2:DO    Yes
 Ecuador    EC    ECU    218    ISO 3166-2:EC    Yes
 Egypt    EG    EGY    818    ISO 3166-2:EG    Yes
 El Salvador    SV    SLV    222    ISO 3166-2:SV    Yes
 Equatorial Guinea    GQ    GNQ    226    ISO 3166-2:GQ    Yes
 Eritrea    ER    ERI    232    ISO 3166-2:ER    Yes
 Estonia    EE    EST    233    ISO 3166-2:EE    Yes
 Ethiopia    ET    ETH    231    ISO 3166-2:ET    Yes
 Falkland Islands (Malvinas)    FK    FLK    238    ISO 3166-2:FK    No
 Faroe Islands    FO    FRO    234    ISO 3166-2:FO    No
 Fiji    FJ    FJI    242    ISO 3166-2:FJ    Yes
 French Guiana    GF    GUF    254    ISO 3166-2:GF    No
 French Polynesia    PF    PYF    258    ISO 3166-2:PF    No
 French Southern Territories    TF    ATF    260    ISO 3166-2:TF    No
 Gabon    GA    GAB    266    ISO 3166-2:GA    Yes
 Gambia    GM    GMB    270    ISO 3166-2:GM    Yes
 Georgia    GE    GEO    268    ISO 3166-2:GE    Yes
 Ghana    GH    GHA    288    ISO 3166-2:GH    Yes
 Gibraltar    GI    GIB    292    ISO 3166-2:GI    No
 Greece    GR    GRC    300    ISO 3166-2:GR    Yes
 Greenland    GL    GRL    304    ISO 3166-2:GL    No
 Grenada    GD    GRD    308    ISO 3166-2:GD    Yes
 Guadeloupe    GP    GLP    312    ISO 3166-2:GP    No
 Guam    GU    GUM    316    ISO 3166-2:GU    No
 Guatemala    GT    GTM    320    ISO 3166-2:GT    Yes
 Guernsey    GG    GGY    831    ISO 3166-2:GG    No
 Guinea    GN    GIN    324    ISO 3166-2:GN    Yes
 Guinea-Bissau    GW    GNB    624    ISO 3166-2:GW    Yes
 Guyana    GY    GUY    328    ISO 3166-2:GY    Yes
 Haiti    HT    HTI    332    ISO 3166-2:HT    Yes
 Heard Island and McDonald Islands    HM    HMD    334    ISO 3166-2:HM    No
 Holy See    VA    VAT    336    ISO 3166-2:VA    Yes
 Honduras    HN    HND    340    ISO 3166-2:HN    Yes
 Hong Kong    HK    HKG    344    ISO 3166-2:HK    No
 Indonesia    ID    IDN    360    ISO 3166-2:ID    Yes
 Iran (Islamic Republic of)    IR    IRN    364    ISO 3166-2:IR    Yes
 Iraq    IQ    IRQ    368    ISO 3166-2:IQ    Yes
 Ireland    IE    IRL    372    ISO 3166-2:IE    Yes
 Isle of Man    IM    IMN    833    ISO 3166-2:IM    No
 Israel    IL    ISR    376    ISO 3166-2:IL    Yes
 Jamaica    JM    JAM    388    ISO 3166-2:JM    Yes
 Japan    JP    JPN    392    ISO 3166-2:JP    Yes
 Jersey    JE    JEY    832    ISO 3166-2:JE    No
 Jordan    JO    JOR    400    ISO 3166-2:JO    Yes
 Kazakhstan    KZ    KAZ    398    ISO 3166-2:KZ    Yes
 Kenya    KE    KEN    404    ISO 3166-2:KE    Yes
 Kiribati    KI    KIR    296    ISO 3166-2:KI    Yes
 Korea (Democratic People's Republic of)    KP    PRK    408    ISO 3166-2:KP    Yes
 Korea (Republic of)    KR    KOR    410    ISO 3166-2:KR    Yes
 Kuwait    KW    KWT    414    ISO 3166-2:KW    Yes
 Kyrgyzstan    KG    KGZ    417    ISO 3166-2:KG    Yes
 Lao People's Democratic Republic    LA    LAO    418    ISO 3166-2:LA    Yes
 Latvia    LV    LVA    428    ISO 3166-2:LV    Yes
 Lebanon    LB    LBN    422    ISO 3166-2:LB    Yes
 Lesotho    LS    LSO    426    ISO 3166-2:LS    Yes
 Liberia    LR    LBR    430    ISO 3166-2:LR    Yes
 Libya    LY    LBY    434    ISO 3166-2:LY    Yes
 Lithuania    LT    LTU    440    ISO 3166-2:LT    Yes
 Macao    MO    MAC    446    ISO 3166-2:MO    No
 Macedonia (the former Yugoslav Republic of)    MK    MKD    807    ISO 3166-2:MK    Yes
 Madagascar    MG    MDG    450    ISO 3166-2:MG    Yes
 Malawi    MW    MWI    454    ISO 3166-2:MW    Yes
 Malaysia    MY    MYS    458    ISO 3166-2:MY    Yes
 Maldives    MV    MDV    462    ISO 3166-2:MV    Yes
 Mali    ML    MLI    466    ISO 3166-2:ML    Yes
 Malta    MT    MLT    470    ISO 3166-2:MT    Yes
 Marshall Islands    MH    MHL    584    ISO 3166-2:MH    Yes
 Martinique    MQ    MTQ    474    ISO 3166-2:MQ    No
 Mauritania    MR    MRT    478    ISO 3166-2:MR    Yes
 Mauritius    MU    MUS    480    ISO 3166-2:MU    Yes
 Mayotte    YT    MYT    175    ISO 3166-2:YT    No
 Micronesia (Federated States of)    FM    FSM    583    ISO 3166-2:FM    Yes
 Moldova (Republic of)    MD    MDA    498    ISO 3166-2:MD    Yes
 Monaco    MC    MCO    492    ISO 3166-2:MC    Yes
 Mongolia    MN    MNG    496    ISO 3166-2:MN    Yes
 Montenegro    ME    MNE    499    ISO 3166-2:ME    Yes
 Montserrat    MS    MSR    500    ISO 3166-2:MS    No
 Morocco    MA    MAR    504    ISO 3166-2:MA    Yes
 Mozambique    MZ    MOZ    508    ISO 3166-2:MZ    Yes
 Myanmar    MM    MMR    104    ISO 3166-2:MM    Yes
 Namibia    NA    NAM    516    ISO 3166-2:NA    Yes
 Nauru    NR    NRU    520    ISO 3166-2:NR    Yes
 Nepal    NP    NPL    524    ISO 3166-2:NP    Yes
 New Caledonia    NC    NCL    540    ISO 3166-2:NC    No
 Nicaragua    NI    NIC    558    ISO 3166-2:NI    Yes
 Niger    NE    NER    562    ISO 3166-2:NE    Yes
 Nigeria    NG    NGA    566    ISO 3166-2:NG    Yes
 Niue    NU    NIU    570    ISO 3166-2:NU    No
 Norfolk Island    NF    NFK    574    ISO 3166-2:NF    No
 Northern Mariana Islands    MP    MNP    580    ISO 3166-2:MP    No
 Oman    OM    OMN    512    ISO 3166-2:OM    Yes
 Palau    PW    PLW    585    ISO 3166-2:PW    Yes
 Palestine, State of    PS    PSE    275    ISO 3166-2:PS    No
 Panama    PA    PAN    591    ISO 3166-2:PA    Yes
 Papua New Guinea    PG    PNG    598    ISO 3166-2:PG    Yes
 Paraguay    PY    PRY    600    ISO 3166-2:PY    Yes
 Peru    PE    PER    604    ISO 3166-2:PE    Yes
 Philippines    PH    PHL    608    ISO 3166-2:PH    Yes
 Pitcairn    PN    PCN    612    ISO 3166-2:PN    No
 Puerto Rico    PR    PRI    630    ISO 3166-2:PR    No
 Qatar    QA    QAT    634    ISO 3166-2:QA    Yes
 Réunion    RE    REU    638    ISO 3166-2:RE    No
 Romania    RO    ROU    642    ISO 3166-2:RO    Yes
 Russian Federation    RU    RUS    643    ISO 3166-2:RU    Yes
 Rwanda    RW    RWA    646    ISO 3166-2:RW    Yes
 Saint Barthélemy    BL    BLM    652    ISO 3166-2:BL    No
 Saint Helena, Ascension and Tristan da Cunha    SH    SHN    654    ISO 3166-2:SH    No
 Saint Kitts and Nevis    KN    KNA    659    ISO 3166-2:KN    Yes
 Saint Lucia    LC    LCA    662    ISO 3166-2:LC    Yes
 Saint Martin (French part)    MF    MAF    663    ISO 3166-2:MF    No
 Saint Pierre and Miquelon    PM    SPM    666    ISO 3166-2:PM    No
 Saint Vincent and the Grenadines    VC    VCT    670    ISO 3166-2:VC    Yes
 Samoa    WS    WSM    882    ISO 3166-2:WS    Yes
 Sao Tome and Principe    ST    STP    678    ISO 3166-2:ST    Yes
 Saudi Arabia    SA    SAU    682    ISO 3166-2:SA    Yes
 Senegal    SN    SEN    686    ISO 3166-2:SN    Yes
 Serbia    RS    SRB    688    ISO 3166-2:RS    Yes
 Seychelles    SC    SYC    690    ISO 3166-2:SC    Yes
 Sierra Leone    SL    SLE    694    ISO 3166-2:SL    Yes
 Singapore    SG    SGP    702    ISO 3166-2:SG    Yes
 Sint Maarten (Dutch part)    SX    SXM    534    ISO 3166-2:SX    No
 Solomon Islands    SB    SLB    090    ISO 3166-2:SB    Yes
 Somalia    SO    SOM    706    ISO 3166-2:SO    Yes
 South Georgia and the South Sandwich Islands    GS    SGS    239    ISO 3166-2:GS    No
 South Sudan    SS    SSD    728    ISO 3166-2:SS    Yes
 Sudan    SD    SDN    729    ISO 3166-2:SD    Yes
 Suriname    SR    SUR    740    ISO 3166-2:SR    Yes
 Svalbard and Jan Mayen    SJ    SJM    744    ISO 3166-2:SJ    No
 Swaziland    SZ    SWZ    748    ISO 3166-2:SZ    Yes
 Sweden    SE    SWE    752    ISO 3166-2:SE    Yes
 Syrian Arab Republic    SY    SYR    760    ISO 3166-2:SY    Yes
 Taiwan, Province of China[a]    TW    TWN    158    ISO 3166-2:TW    No
 Tajikistan    TJ    TJK    762    ISO 3166-2:TJ    Yes
 Tanzania, United Republic of    TZ    TZA    834    ISO 3166-2:TZ    Yes
 Timor-Leste    TL    TLS    626    ISO 3166-2:TL    Yes
 Togo    TG    TGO    768    ISO 3166-2:TG    Yes
 Tokelau    TK    TKL    772    ISO 3166-2:TK    No
 Tonga    TO    TON    776    ISO 3166-2:TO    Yes
 Trinidad and Tobago    TT    TTO    780    ISO 3166-2:TT    Yes
 Tunisia    TN    TUN    788    ISO 3166-2:TN    Yes
 Turkey    TR    TUR    792    ISO 3166-2:TR    Yes
 Turkmenistan    TM    TKM    795    ISO 3166-2:TM    Yes
 Turks and Caicos Islands    TC    TCA    796    ISO 3166-2:TC    No
 Tuvalu    TV    TUV    798    ISO 3166-2:TV    Yes
 Uganda    UG    UGA    800    ISO 3166-2:UG    Yes
 Ukraine    UA    UKR    804    ISO 3166-2:UA    Yes
 United Arab Emirates    AE    ARE    784    ISO 3166-2:AE    Yes
 United Kingdom of Great Britain and Northern Ireland    GB    GBR    826    ISO 3166-2:GB    Yes
 United States Minor Outlying Islands    UM    UMI    581    ISO 3166-2:UM    No
 Uruguay    UY    URY    858    ISO 3166-2:UY    Yes
 Uzbekistan    UZ    UZB    860    ISO 3166-2:UZ    Yes
 Vanuatu    VU    VUT    548    ISO 3166-2:VU    Yes
 Venezuela (Bolivarian Republic of)    VE    VEN    862    ISO 3166-2:VE    Yes
 Viet Nam    VN    VNM    704    ISO 3166-2:VN    Yes
 Virgin Islands (British)    VG    VGB    092    ISO 3166-2:VG    No
 Virgin Islands (U.S.)    VI    VIR    850    ISO 3166-2:VI    No
 Wallis and Futuna    WF    WLF    876    ISO 3166-2:WF    No
 Western Sahara    EH    ESH    732    ISO 3166-2:EH    No
 Yemen    YE    YEM    887    ISO 3166-2:YE    Yes
 Zambia    ZM    ZMB    894    ISO 3166-2:ZM    Yes
 Zimbabwe    ZW


 */
