<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string emp_pk;
    emp_pk       = Request["emp_pk"].ToString();
    string contract_type       = Request["contract_type"].ToString();
    string SQL
 = "select a.contract_no, " +
        "       b.full_name, " +
        "       (select code_fnm " +
        "        from vhr_hr_code v " +
        "        where b.nation = v.code and id = 'HR0009') " +
        "           nation, " +
        "       decode(length(b.birth_dt), 4, b.birth_dt, to_char(to_date(b.birth_dt, 'yyyymmdd'), 'dd-mm-yyyy')) birth_dt, " +
        "       b.permanent_addr, " +
        "       b.person_id, " +
        "       to_char(to_date(b.issue_dt, 'yyyymmdd'), 'dd-mm-yyyy') issue_dt, " +
        "       (select code_nm " +
        "        from vhr_hr_code v " +
        "        where b.place_per_id = v.code and id = 'HR0014') " +
        "           place_per_id, " +
        "       to_char(to_date(a.begin_probation, 'yyyymmdd'), 'dd-mm-yyyy') begin_probation, " +
        "       to_char(to_date(a.end_probation, 'yyyymmdd'), 'dd-mm-yyyy') end_probation, " +
        "       to_char(a.pro_sal, '999,999,999') pro_sal, " +
        "       to_char(to_date(b.begin_probation, 'yyyymmdd') - 1, 'dd-mm-yyyy') crt_dt " +
        "from thr_labour_contract a, thr_employee b, tco_org c, thr_work_group d " +
        "where     a.del_if = 0 " +
        "      and b.del_if = 0 " +
        "      and c.del_if = 0 " +
        "      and d.del_if = 0 " +
        "      and b.pk = a.thr_employee_pk " +
        "      and c.pk = b.tco_org_pk " +
        "      and d.pk = b.thr_wg_pk " +
        "      and b.pk in (" + emp_pk + ") " +
        "      and a.contract_type="+contract_type+" " ;

   // Response.Write(SQL);
   // Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    SQL
    = "select code,code_nm  " +
        "from vhr_hr_code " +
        "where id='HR0036'  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    /*if (irow_name != 24)
    {
        Response.Write("There is enough information of HR code Labour Contract Report!");
        Response.End();
    }*/
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 15">
<meta name=Originator content="Microsoft Word 15">
<link rel=File-List href="rpt_probation_contract_shn_sale_files/filelist.xml">
<title>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceName"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>JS Horizon</o:Author>
  <o:Description>.                                                                   최초 생성자ID : S001_16607619 &#13;&#10;최초 문서생성 시간 : 2016-10-04 13:48:21 &#13;&#10;암호화 해제 사용자ID : S001_12502146&#13;&#10;해제 시간 : 2016-11-29 12:09 &#13;&#10;복호화 수행 PC IP : 10.95.13.130 &#13;&#10;복호화 수행 PC MAC : 082E5F15B59B;</o:Description>
  <o:LastAuthor>DEV04</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>1</o:TotalTime>
  <o:LastPrinted>2014-12-09T07:15:00Z</o:LastPrinted>
  <o:Created>2016-12-12T02:36:00Z</o:Created>
  <o:LastSaved>2016-12-12T02:36:00Z</o:LastSaved>
  <o:Pages>3</o:Pages>
  <o:Words>795</o:Words>
  <o:Characters>4537</o:Characters>
  <o:Company>HORIZON</o:Company>
  <o:Lines>37</o:Lines>
  <o:Paragraphs>10</o:Paragraphs>
  <o:CharactersWithSpaces>5322</o:CharactersWithSpaces>
  <o:Version>15.00</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<link rel=dataStoreItem
href="rpt_probation_contract_shn_sale_files/item0001.xml"
target="rpt_probation_contract_shn_sale_files/props002.xml">
<link rel=themeData href="rpt_probation_contract_shn_sale_files/themedata.thmx">
<link rel=colorSchemeMapping
href="rpt_probation_contract_shn_sale_files/colorschememapping.xml">
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:HideGrammaticalErrors/>
  <w:ActiveWritingStyle Lang="EN-US" VendorID="64" DLLVersion="131078"
   NLCheck="1">1</w:ActiveWritingStyle>
  <w:ActiveWritingStyle Lang="FR" VendorID="64" DLLVersion="131078" NLCheck="1">1</w:ActiveWritingStyle>
  <w:ActiveWritingStyle Lang="EN-GB" VendorID="64" DLLVersion="131078"
   NLCheck="1">1</w:ActiveWritingStyle>
  <w:ActiveWritingStyle Lang="DE" VendorID="64" DLLVersion="131078" NLCheck="1">1</w:ActiveWritingStyle>
  <w:TrackMoves>false</w:TrackMoves>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>ZH-TW</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
   <w:UseFELayout/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" LatentStyleCount="371">
  <w:LsdException Locked="false" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" Priority="99" SemiHidden="true"
   UnhideWhenUsed="true" Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" Priority="99" SemiHidden="true"
   UnhideWhenUsed="true" Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" Priority="99" SemiHidden="true"
   Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="99" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if !mso]><object
 classid="clsid:38481807-CA0E-42D2-BF39-B33AF135CC4D" id=ieooui></object>
<style>
st1\:*{behavior:url(#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;
	mso-font-alt:바탕;
	mso-font-charset:129;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:1 151388160 16 0 524288 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Cambria;
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1073743103 0 0 415 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520081665 -1073717157 41 0 66047 0;}
@font-face
	{font-family:"\@Batang";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:129;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:1 151388160 16 0 524288 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;}
h1
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	font-size:18.0pt;
	font-family:"Times New Roman",serif;
	mso-font-kerning:0pt;}
h2
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
h3
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:3;
	font-size:11.0pt;
	font-family:"Times New Roman",serif;
	font-weight:normal;
	font-style:italic;}
h4
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:4;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	font-style:italic;}
h5
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-next:Normal;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:5;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;
	font-weight:normal;
	font-style:italic;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-unhide:no;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-link:"Footer Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.0in right 6.0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;}
p.MsoTitle, li.MsoTitle, div.MsoTitle
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:center;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;
	font-weight:bold;}
p.MsoBodyText, li.MsoBodyText, div.MsoBodyText
	{mso-style-unhide:no;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;
	font-style:italic;}
p.MsoBodyTextIndent, li.MsoBodyTextIndent, div.MsoBodyTextIndent
	{mso-style-unhide:no;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:6.0pt;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;
	font-style:italic;}
p.MsoBodyText2, li.MsoBodyText2, div.MsoBodyText2
	{mso-style-unhide:no;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;}
p.MsoBodyText3, li.MsoBodyText3, div.MsoBodyText3
	{mso-style-unhide:no;
	margin-top:6.0pt;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;
	font-weight:bold;}
p.MsoBodyTextIndent2, li.MsoBodyTextIndent2, div.MsoBodyTextIndent2
	{mso-style-unhide:no;
	margin:0in;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:.5in;
	mso-pagination:widow-orphan;
	tab-stops:337.5pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	mso-style-unhide:no;
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:"Tahoma",sans-serif;
	mso-fareast-font-family:Batang;}
span.FooterChar
	{mso-style-name:"Footer Char";
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-parent:"";
	mso-style-link:Footer;
	mso-ansi-font-size:12.0pt;
	mso-bidi-font-size:12.0pt;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	mso-fareast-font-family:Batang;
	mso-fareast-language:ZH-TW;}
 /* Page Definitions */
 @page
	{mso-footnote-separator:url("rpt_probation_contract_shn_sale_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_probation_contract_shn_sale_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_probation_contract_shn_sale_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_probation_contract_shn_sale_files/header.htm") ecs;}
@page WordSection1
	{size:595.45pt 841.7pt;
	margin:.5in 37.45pt .5in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:0in;
	mso-page-numbers:1;
	mso-even-footer:url("rpt_probation_contract_shn_sale_files/header.htm") ef1;
	mso-footer:url("rpt_probation_contract_shn_sale_files/header.htm") f1;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
@page WordSection2
	{size:595.45pt 841.7pt;
	margin:.5in 37.45pt .5in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:0in;
	mso-even-footer:url("rpt_probation_contract_shn_sale_files/header.htm") ef2;
	mso-footer:url("rpt_probation_contract_shn_sale_files/header.htm") f2;
	mso-paper-source:0;}
div.WordSection2
	{page:WordSection2;}
 /* List Definitions */
 @list l0
	{mso-list-id:224726218;
	mso-list-template-ids:1679089980;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:456336802;
	mso-list-type:hybrid;
	mso-list-template-ids:-1336271858 1070250026 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-weight:bold;
	mso-ansi-font-style:normal;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:684554304;
	mso-list-type:hybrid;
	mso-list-template-ids:-321095186 -1922242338 -1859730488 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";}
@list l2:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-style:normal;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1130787887;
	mso-list-template-ids:-2342884;}
@list l3:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";}
@list l3:level2
	{mso-level-start-at:2;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-style:normal;}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4
	{mso-list-id:1239092688;
	mso-list-template-ids:-2342884;}
@list l4:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";}
@list l4:level2
	{mso-level-start-at:2;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-style:normal;}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l5
	{mso-list-id:1312833911;
	mso-list-template-ids:-369592942;}
@list l5:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";}
@list l5:level2
	{mso-level-tab-stop:2.75in;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-2.0in;}
@list l5:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l5:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l5:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l5:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l5:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l5:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l5:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l6
	{mso-list-id:1363942322;
	mso-list-type:hybrid;
	mso-list-template-ids:148806402 -615345864 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l6:level1
	{mso-level-tab-stop:2.25in;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-2.0in;
	mso-ansi-font-weight:bold;
	mso-ansi-font-style:normal;}
@list l6:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l6:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l6:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l6:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l7
	{mso-list-id:1552837502;
	mso-list-template-ids:1647242580;}
@list l7:level1
	{mso-level-start-at:2;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-weight:bold;
	mso-ansi-font-style:normal;}
@list l7:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l7:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l7:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l7:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l8
	{mso-list-id:1588424248;
	mso-list-template-ids:-2077480312;}
@list l8:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:"Times New Roman";}
@list l8:level2
	{mso-level-tab-stop:2.75in;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-2.0in;}
@list l8:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l8:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l8:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l8:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l8:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l8:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l8:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-language:ZH-TW;}
table.MsoTableGrid
	{mso-style-name:"Table Grid";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-unhide:no;
	border:solid windowtext 1.0pt;
	mso-border-alt:solid windowtext .5pt;
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-border-insideh:.5pt solid windowtext;
	mso-border-insidev:.5pt solid windowtext;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-language:ZH-TW;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=WordSection1>
    <%
        for (int i = 0; i < irow; i++)
        { %>
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-table-lspace:9.0pt;margin-left:6.75pt;mso-table-rspace:
 9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:
 margin;mso-table-left:left;mso-table-top:-1.25pt;mso-padding-alt:0in 5.4pt 0in 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:.5in'>
  <td width=226 valign=top style='width:169.55pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:.5in'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  margin;mso-element-top:-1.25pt;mso-height-rule:exactly'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:10.0pt'>Hợp đồng số: </span></b><!--[if supportFields]><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt;color:red'><span
  style='mso-element:field-begin'></span><span
  style='mso-spacerun:yes'> </span>MERGEFIELD LC_number <span style='mso-element:
  field-separator'></span></span></b><![endif]--><b style='mso-bidi-font-weight:
  normal'><span style='font-size:10.0pt;color:red'><span style='mso-no-proof:
  yes'><%=dt_total.Rows[i]["contract_no"].ToString() %></span></span></b><!--[if supportFields]><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt;color:red'><span
  style='mso-element:field-end'></span></span></b><![endif]--><b
  style='mso-bidi-font-weight:normal'><span style='font-size:10.0pt;color:red'><o:p></o:p></span></b></p>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  margin;mso-element-top:-1.25pt;mso-height-rule:exactly'><b style='mso-bidi-font-weight:
  normal'><i style='mso-bidi-font-style:normal'><span style='font-size:10.0pt'>Trainning
  No</span></i>. </b><b style='mso-bidi-font-weight:normal'><span
  style='mso-fareast-language:KO'><o:p></o:p></span></b></p>
  </td>
 </tr>
</table>

<p class=MsoTitle align=left style='text-align:left'><span
style='mso-spacerun:yes'>   </span>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT <st1:place
w:st="on"><st1:country-region w:st="on">NAM</st1:country-region></st1:place></p>

<h4 align=left style='margin-left:1.0in;text-align:left;text-indent:.5in'><st1:PlaceName
w:st="on"><span style='font-weight:normal'>SOCIALIST</span></st1:PlaceName><span
style='font-weight:normal'> <st1:PlaceType w:st="on">REPUBLIC</st1:PlaceType>
OF <st1:place w:st="on"><st1:country-region w:st="on">VIETNAM</st1:country-region></st1:place><o:p></o:p></span></h4>

<h2 align=left style='margin-left:1.0in;text-align:left;text-indent:.5in'><span
style='mso-spacerun:yes'>      </span>Độc lập – Tự do – Hạnh phúc</h2>

<h4 style='margin-left:1.0in;text-indent:.5in'><span style='font-weight:normal'>Independence
– Freedom - Happiness<o:p></o:p></span></h4>

<p class=MsoNormal align=center style='margin-left:1.0in;text-align:center;
text-indent:.5in'>-----------------------------------</p>

<p class=MsoNormal align=center style='text-align:center'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<h1><span style='font-size:12.0pt'>HỢP ĐỒNG ĐÀO TẠO<o:p></o:p></span></h1>

<p class=MsoNormal align=center style='text-align:center'><b><i>TRAINING AGREEMENT<o:p></o:p></i></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
tab-stops:4.75in'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
tab-stops:4.75in'>Chúng tôi, một bên là <b style='mso-bidi-font-weight:normal'>Ông/Bà:<span
style='mso-spacerun:yes'>  </span></b><b style='mso-bidi-font-weight:normal'><span
lang=FR style='mso-ansi-language:FR'>LEE WON SUK</span></b><span
style='mso-tab-count:1'>                                 </span>Quốc tịch<span
style='mso-bidi-font-weight:bold'>:<span style='mso-spacerun:yes'>  </span>Hàn
Quốc</span> </p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
tab-stops:4.75in'><i>We, one party to the agreement, <b style='mso-bidi-font-weight:
normal'>Mr/Ms:</b><span style='mso-tab-count:1'>                                                  </span>Nationality:
Korean<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Chức vụ: <span style='mso-bidi-font-weight:bold'>Giám
Đốc Hành chính- Nhân Sự <span style='mso-tab-count:1'>                                 </span><o:p></o:p></span></p>

<h5 style='margin-left:.25in;text-indent:.25in;tab-stops:4.75in'><span
style='font-size:12.0pt'>Position:<span style='mso-spacerun:yes'>  </span>HR
&amp; GA Director<span style='mso-tab-count:1'>                                                       </span><o:p></o:p></span></h5>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Đại diện cho :<span style='mso-spacerun:yes'> 
</span><b>Ngân hàng TNHH MTV Shinhan Việt <st1:place w:st="on"><st1:country-region
 w:st="on">Nam</st1:country-region></st1:place> </b><b><span style='mso-fareast-language:
KO'>(</span>“Ngân hàng”)<span style='mso-tab-count:1'>       </span></b></p>

<p class=MsoNormal style='margin-left:.25in;text-align:justify;text-justify:
inter-ideograph;text-indent:.25in;tab-stops:4.75in'><i>On behalf of:</i><span
style='mso-spacerun:yes'>  </span><b style='mso-bidi-font-weight:normal'><i
style='mso-bidi-font-style:normal'>Shinhan Bank Vietnam</i></b><i
style='mso-bidi-font-style:normal'> </i><b style='mso-bidi-font-weight:normal'><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO'>(the “Bank”)</span></i></b><span
style='mso-tab-count:1'>                 </span><i><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Địa chỉ: <span lang=FR style='mso-ansi-language:
FR'>138-142 Hai Bà Trưng, P. Đa Kao, Q.1, TPHCM</span><span style='mso-tab-count:
1'>          </span>Điện thoại: <span lang=FR style='mso-ansi-language:FR'>3
8291581</span></p>

<p class=MsoNormal style='margin-left:.25in;text-align:justify;text-justify:
inter-ideograph;text-indent:.25in;tab-stops:4.75in'><i>Address:<span
style='mso-tab-count:1'>                                                                                        </span></i><i
style='mso-bidi-font-style:normal'>Telephone No.:<span style='mso-bidi-font-style:
italic'><span style='mso-tab-count:1'>      </span><span style='mso-tab-count:
1'>            </span><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-justify:
inter-ideograph;tab-stops:4.75in'><span lang=FR style='mso-ansi-language:FR'>Và
một bên là <b style='mso-bidi-font-weight:normal'>Ông/Bà (Trainee): <span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["full_name"].ToString() %></span></b><span
style='mso-tab-count:1'>                </span></span>Quốc tịch:<span
style='mso-tab-count:1'> </span><span style='color:red'><%=dt_total.Rows[i]["nation"].ToString() %></span></p>

<h3 style='tab-stops:4.75in'><span style='font-size:12.0pt'>And, the other party
to the agreement, <b style='mso-bidi-font-weight:normal'>Mr/Ms:</b><span
style='mso-tab-count:1'>                                         </span>Nationality:<span
style='mso-tab-count:1'>           </span><o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Sinh ngày:<span
style='mso-spacerun:yes'>             </span><span
style='mso-spacerun:yes'> </span><span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["birth_dt"].ToString() %></span><span
style='mso-tab-count:1'>           </span><span lang=FR style='mso-ansi-language:
FR'><span style='mso-tab-count:3'>                                    </span></span></p>

<h3 style='margin-left:.25in;text-indent:.25in'><span style='font-size:12.0pt'>Date
of birth <span style='mso-tab-count:4'>                                       </span><o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Địa chỉ thường trú: <span style='color:red;
mso-no-proof:yes'><%=dt_total.Rows[i]["permanent_addr"].ToString() %></span><i><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph'><i><span
style='mso-spacerun:yes'> </span>Permanent address:<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Số CMND/Hộ chiếu:<span style='mso-tab-count:
1'>  </span><span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["person_id"].ToString() %></span><span
style='mso-tab-count:1'>      </span> cấp ngày: <span style='color:red;
mso-no-proof:yes'><%=dt_total.Rows[i]["issue_dt"].ToString() %></span><span style='mso-tab-count:1'> </span><span
style='mso-spacerun:yes'>  </span>tại<span style='mso-spacerun:yes'>   </span><span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["place_per_id"].ToString() %></span></p>

<p class=MsoNormal style='margin-left:.25in;text-align:justify;text-justify:
inter-ideograph;text-indent:.25in'><i>ID card No/ PP:</i><span
style='mso-tab-count:1'>          </span><i style='mso-bidi-font-style:normal'><span
style='mso-spacerun:yes'>                         </span><span
style='mso-spacerun:yes'> </span>i<span style='mso-bidi-font-style:italic'>ssued
on</span> <span style='mso-spacerun:yes'>                   </span><span
style='mso-bidi-font-style:italic'>in </span><span style='mso-tab-count:1'>       </span><span
style='mso-spacerun:yes'>  </span><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:12.0pt;text-align:justify;text-justify:
inter-ideograph'>Thỏa thuận ký kết hợp đồng đào tạo <span
style='mso-spacerun:yes'> </span>và cam kết thực hiện những điều khoản sau đây:</p>

<h3><span style='font-size:12.0pt'>Agree to sign this training agreement, and
commit to conduct with all the following provisions:<o:p></o:p></span></h3>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b
style='mso-bidi-font-weight:normal'>Điều 1. Thời gian và nội dung đào tạo.<o:p></o:p></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b
style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'>Article1.</i>
<i style='mso-bidi-font-style:normal'>Training duration and content</i> <o:p></o:p></b></p>

<h2 align=left style='margin-left:.5in;text-align:left;text-indent:-.25in;
mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-weight:normal;mso-bidi-font-weight:
bold'>Thời gian đào tạo: <span style='mso-spacerun:yes'>   </span><span
style='mso-tab-count:1'>   </span></span><span style='color:red;mso-no-proof:
yes'><%=dt_total.Rows[i]["begin_probation"].ToString() %></span><span style='font-weight:normal;mso-bidi-font-weight:
bold'><span style='mso-tab-count:2'>                  </span>đến<span
style='mso-spacerun:yes'>    </span></span><span style='color:red;mso-no-proof:
yes'><%=dt_total.Rows[i]["end_probation"].ToString() %></span><span style='font-weight:normal;mso-bidi-font-weight:
bold'><o:p></o:p></span></h2>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>Training
period:<span style='mso-spacerun:yes'>    </span><span style='mso-tab-count:
3'>                              </span>to<o:p></o:p></i></p>

<h2 align=left style='margin-left:.5in;text-align:left;text-indent:-.25in;
mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";font-weight:normal;mso-bidi-font-weight:
bold'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='font-weight:normal;mso-bidi-font-weight:
bold'>Địa điểm đào tạo: tại ngân hàng or địa điểm khác do Ngân hàng thuê. <o:p></o:p></span></h2>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>Training
venue: at the Bank or other place employed by the Bank.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-weight:bold'>Nội dung
đào tạo:</span> Ngân hàng sẽ thông báo chi tiết nội dung đào tạo, lịch đào tạo
cụ thể cho học viên (đính kèm)</p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>Training
content: the details is in attachment.<o:p></o:p></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b
style='mso-bidi-font-weight:normal'>Điều 2. Quyền và nghĩa vụ của học viên.<o:p></o:p></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b
style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:normal'>Article
2.</i> <i><span style='mso-bidi-font-weight:bold'>Obligations, rights and
benefits of the trainee</span></i><o:p></o:p></b></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'><span
style='font-size:8.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-weight:bold'>Phụ cấp:
</span>Ngân hàng hỗ trợ người học phụ cấp là:<b style='mso-bidi-font-weight:
normal'> <span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["pro_sal"].ToString() %> </span></b>VNĐ/tháng
nếu học viên đạt được chỉ tiêu theo quy chế trả hoa hồng và thưởng của Ngân
hàng. </p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i style='mso-bidi-font-style:normal'>Allowance: The bank will
support the allowance of <span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["pro_sal"].ToString() %></span><span
style='color:red'> </span>VNĐ/monthly if trainee get the target as<span
style='mso-spacerun:yes'>  </span>Regulations on Incentive scheme of Commission
and Bonus.<o:p></o:p></i></p>



<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-weight:bold'>Chi phí
đào tạo: </span><span style='mso-spacerun:yes'> </span>học viên sẽ không phải
trả bất kỳ chi phí đào tạo nào. <span style='mso-spacerun:yes'> </span>Trong
quá trình đào tạo nếu học viên tham gia vào quá trình tạo ra sản phẩm thì ngoài
phụ cấp trên, học viên sẽ được hưởng thêm một khoản phụ cấp khác giống mức phụ
cấp được áp dụng cho nhân viên chính thức của Ngân hàng. </p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><i style='mso-bidi-font-style:normal'>Training
fee: the trainee is trained at free of charge;<span style='mso-spacerun:yes'> 
</span>and in training period if the trainer work any job for the bank, the
additional allowance will be granted as the official staff allowance
regulations.</i></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i><o:p>&nbsp;</o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-weight:bold'>Được ký
hợp đồng chính thức với ngân hàng khi kết thúc khóa đào tạo đạt yêu cầu. </span></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>Be
signed the Labor Contract<span style='mso-spacerun:yes'>  </span>with the bank
after meeting the training requirement.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'><span
style='font-size:7.0pt;mso-bidi-font-size:12.0pt'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-weight:bold'>Tham dự
đầy đủ và tuân thủ đúng nội quy khóa đào tạo, tuân thủ nội quy của Ngân hàng.</span></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'><span
style='mso-bidi-font-weight:bold'>Comply with training policies and internal
regulation of the Bank.<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'><span
style='font-size:5.0pt;mso-bidi-font-size:12.0pt;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman";mso-bidi-font-weight:bold'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-bidi-font-weight:bold'>Người
lao động phải đóng thuế thu nhập cá nhân theo quy định của pháp luật.<o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'><span
style='mso-bidi-font-weight:bold'>You will be responsible for your own tax
liabilities as regulated by the law.<o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'><span
style='font-size:7.0pt;mso-bidi-font-size:12.0pt;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'>Điều 3. Quyền và
nghĩa vụ của Ngân hàng.<o:p></o:p></b></p>

<p class=MsoNormal><b><i>Article 3 .Obligations, rights and benefits of the Bank</i></b><b
style='mso-bidi-font-weight:normal'><o:p></o:p></b></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Thay đổi lịch đào tạo hoặc địa điểm đào tạo, trường
hợp này ngân hàng sẽ thông báo cho học viên biết lý lo thay đổi; đồng thời cung
cấp cho học viên lịch đào tạo và địa điểm thay đổi mới.</p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>Any
change of the training schedule &amp; venue at some case, the bank should inform
the trainee about these changes.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Từ chối hoặc không tiếp nhân học viên vi phạm nội
quy của khóa đào tạo và nội quy Ngân hàng.</p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>The
bank has the rights to refuse any trainee who do not comply with the training
policies and internal regulations of the Bank.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Có quyền từ chối ký hợp đồng lao động của học
viên nếu xét thấy kết quả đào tạo của học viên không đạt.</p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>The
bank has right to reject signing the labor contract to any trainee who has not
satisfy the training result.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Thanh toán đúng hạn và đầy đủ phụ cấp cho học
viên như cam kết.</p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>To
fully and timely pay the trainee the allowance as commitment.<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-indent:-.25in;mso-list:l2 level1 lfo1;
tab-stops:list .5in'><![if !supportLists]><span style='mso-fareast-font-family:
"Times New Roman"'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Ký hợp đồng lao động với học viên đạt yêu cầu
khi kết thúc khóa đào tạo.</p>

<p class=MsoNormal style='margin-left:.5in'><i style='mso-bidi-font-style:normal'>To
sign the Labor Contract<span style='mso-spacerun:yes'>  </span>with the trainee
who meet the training requirement.<o:p></o:p></i></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'>Điều 4. Điều khoản
khác.<o:p></o:p></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><i style='mso-bidi-font-style:
normal'>Article 4. Other<o:p></o:p></i></b></p>

<p class=MsoNormal style='margin-left:.25in;text-indent:.25in'>Hai bên có quyền
từ bỏ việc đào tạo và không ký kết hợp đồng làm việc mà không cần báo trước.</p>

<p class=MsoNormal style='text-indent:.5in'><i style='mso-bidi-font-style:normal'><span
style='font-size:11.0pt'>Both parties shall be entitled to terminate this
agreement without any advance notice.</span></i></p>

<h2 align=left style='text-align:left'>Điều 5: Điều khoản thi hành.</h2>

<h3><b><span style='font-size:12.0pt'>Article 5: Implementation provision<o:p></o:p></span></b></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Những vấn đề không ghi trong hợp đồng đào tạo
này thì áp dụng theo quy định của pháp luật hiện hành. </p>

<p class=MsoBodyText style='margin-left:.5in'>For other issues which are not
stated in the agreement, the current regulations shall be applied. </p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Hợp đồng đào tạo này được lập thành 02 bản có
giá trị ngang nhau, mỗi bên giữ một bản và có hiệu lực từ ngày <b
style='mso-bidi-font-weight:normal'><span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["begin_probation"].ToString() %></span></b>.<span
style='mso-spacerun:yes'>  </span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph'><i
style='mso-bidi-font-style:normal'>The training agreements are made in
duplicate with equal validity, each party retains one original.<span
style='mso-spacerun:yes'>  </span>The agreements come into effect on <span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["begin_probation"].ToString() %></span><b style='mso-bidi-font-weight:
normal'><span style='color:red'>.</span><o:p></o:p></b></i></p>

<p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Hợp
đồng này lập tại Ngân hàng, ngày <span style='mso-spacerun:yes'> </span><b
style='mso-bidi-font-weight:normal'><span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["crt_dt"].ToString() %></span>.</b></span><span
style='mso-fareast-language:KO;font-style:normal;mso-bidi-font-style:italic'><o:p></o:p></span></p>

<p class=MsoBodyText>This agreement is signed at the Bank, date<span
style='mso-spacerun:yes'>                </span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width=662
 style='width:6.9in;margin-left:.2in;border-collapse:collapse;mso-yfti-tbllook:
 480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=288 valign=top style='width:3.0in;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Học
  viên<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'>Trainee<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal'>Chữ ký/</span><span
  style='mso-bidi-font-style:normal'>Signature: <span style='mso-tab-count:
  1'>      </span>______________<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal'>Tên</span><span
  style='mso-bidi-font-style:normal'>/Name: <o:p></o:p></span></p>
  </td>
  <td width=374 valign=top style='width:3.9in;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Ngân
  hàng Shinhan Bank Việt <st1:place w:st="on"><st1:country-region w:st="on">Nam</st1:country-region></st1:place><o:p></o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Shinhan
  Bank Vietnam<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='mso-fareast-language:KO;font-style:normal;
  mso-bidi-font-style:italic'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Chữ
  ký/Signature: <span style='mso-tab-count:1'>      </span></span><span
  style='mso-bidi-font-style:normal'>______________<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText style='line-height:12.0pt'><span style='font-style:normal'>Tên</span><span
  style='mso-bidi-font-style:normal'>/Name: <span style='mso-tab-count:2'>                 </span></span><b
  style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:KO;
  font-style:normal'>LEE WON SUK</span></b><span style='mso-fareast-language:
  KO;mso-bidi-font-style:normal'><o:p></o:p></span></p>
  <p class=MsoBodyText style='line-height:12.0pt'><span style='font-style:normal'>Chức
  vụ</span><span style='mso-bidi-font-style:normal'>/Position: </span><span
  style='mso-fareast-language:KO;mso-bidi-font-style:normal'><span
  style='mso-spacerun:yes'>      </span>HR &amp; GA </span><span
  style='mso-bidi-font-style:normal'>Director </span><span style='font-style:
  normal;mso-bidi-font-style:italic'><o:p></o:p></span></p>
  </td>
 </tr>
</table>
<%
     if (i == irow - 1)//nhan vien cuoi cung 
     { 
         %>
         
<b><span style='font-size:12.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all >
</span>&nbsp;</b>
         <%
     }
     else
     {   
  %>
    
<b><span style='font-size:12.0pt;font-family:"Times New Roman";mso-fareast-font-family:
"Times New Roman";mso-ansi-language:EN-US;mso-fareast-language:EN-US;
mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span>&nbsp;</b>
<% 
     }
        %>

    <%
        } %>
</div>


</body>

</html>
