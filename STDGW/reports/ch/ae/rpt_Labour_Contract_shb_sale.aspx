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
        "       b.n_country2, " +
        "       b.permanent_addr, " +
        "       b.person_id, " +
        "       to_char(to_date(b.issue_dt, 'yyyymmdd'), 'dd-mm-yyyy') issue_dt, " +
        "       (select code_nm " +
        "        from vhr_hr_code v " +
        "        where b.place_per_id = v.code and id = 'HR0014') " +
        "           place_per_id, " +
        "       b.social_no, " +
        "       b.social_dt, " +
        "       (select code_nm " +
        "        from vhr_hr_code v " +
        "        where b.social_place = v.code and id = 'HR0013') " +
        "           social_place, " +
        "       b.pit_tax_no, " +
        "       to_char(to_date(a.begin_contract, 'yyyymmdd'), 'dd-mm-yyyy') begin_contract, " +
        "       to_char(to_date(a.end_contract, 'yyyymmdd'), 'dd-mm-yyyy') end_contract, " +
        "       a.basic_sal, " +
        "       to_char(to_date(b.begin_contract, 'yyyymmdd') - 1, 'dd-mm-yyyy') crt_dt " +
        "from thr_labour_contract a, thr_employee b, tco_org c, thr_work_group d " +
        "where     a.del_if = 0 " +
        "      and b.del_if = 0 " +
        "      and c.del_if = 0 " +
        "      and d.del_if = 0 " +
        "      and b.pk = a.thr_employee_pk " +
        "      and c.pk = b.tco_org_pk " +
        "      and d.pk = b.thr_wg_pk " +
        "      and b.pk in (" + emp_pk + ") " +
        "      and a.contract_type='"+contract_type+"'  " ;

    //Response.Write(SQL);
    //Response.End();
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
        "where id='HR0036' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    /*if (irow_name != 23)
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
<link rel=File-List href="rpt_labour_contract_shb_sale_files/filelist.xml">
<title>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="PlaceType"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>JS Horizon</o:Author>
  <o:Description>.                                                                   최초 생성자ID : S001_16607619 &#13;&#10;최초 문서생성 시간 : 2016-09-07 15:28:53 &#13;&#10;암호화 해제 사용자ID : S001_12502146&#13;&#10;해제 시간 : 2016-11-29 12:09 &#13;&#10;복호화 수행 PC IP : 10.95.13.130 &#13;&#10;복호화 수행 PC MAC : 082E5F15B59B;</o:Description>
  <o:LastAuthor>DEV04</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>1</o:TotalTime>
  <o:LastPrinted>2014-12-09T07:50:00Z</o:LastPrinted>
  <o:Created>2016-12-11T09:16:00Z</o:Created>
  <o:LastSaved>2016-12-11T09:16:00Z</o:LastSaved>
  <o:Pages>4</o:Pages>
  <o:Words>1375</o:Words>
  <o:Characters>7842</o:Characters>
  <o:Company>HORIZON</o:Company>
  <o:Lines>65</o:Lines>
  <o:Paragraphs>18</o:Paragraphs>
  <o:CharactersWithSpaces>9199</o:CharactersWithSpaces>
  <o:Version>15.00</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<link rel=dataStoreItem href="rpt_labour_contract_shb_sale_files/item0001.xml"
target="rpt_labour_contract_shb_sale_files/props002.xml">
<link rel=themeData href="rpt_labour_contract_shb_sale_files/themedata.thmx">
<link rel=colorSchemeMapping
href="rpt_labour_contract_shb_sale_files/colorschememapping.xml">
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:HideSpellingErrors/>
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
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:UseWord2010TableStyleRules/>
   <w:DontGrowAutofit/>
   <w:DontUseIndentAsNumberingTabStop/>
   <w:FELineBreak11/>
   <w:WW11IndentRules/>
   <w:DontAutofitConstrainedTables/>
   <w:AutofitLikeWW11/>
   <w:HangulWidthLikeWW11/>
   <w:UseNormalStyleForList/>
   <w:DontVertAlignCellWithSp/>
   <w:DontBreakConstrainedForcedTables/>
   <w:DontVertAlignInTxbx/>
   <w:Word11KerningPairs/>
   <w:CachedColBalance/>
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
	mso-fareast-font-family:Batang;}
 /* Page Definitions */
 @page
	{mso-footnote-separator:url("rpt_labour_contract_shb_sale_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_labour_contract_shb_sale_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_labour_contract_shb_sale_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_labour_contract_shb_sale_files/header.htm") ecs;}
@page WordSection1
	{size:595.45pt 841.7pt;
	margin:.7in .5in .5in .6in;
	mso-header-margin:.5in;
	mso-footer-margin:0in;
	mso-page-numbers:1;
	mso-even-footer:url("rpt_labour_contract_shb_sale_files/header.htm") ef1;
	mso-footer:url("rpt_labour_contract_shb_sale_files/header.htm") f1;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
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
@list l1:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
@list l1:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
@list l6:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
@list l6:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
@list l7:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
@list l7:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
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
	font-family:"Times New Roman",serif;}
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
	font-family:"Times New Roman",serif;}
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
    {
     %>
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-table-lspace:9.0pt;margin-left:6.75pt;mso-table-rspace:
 9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:
 margin;mso-table-left:left;mso-table-top:-1.25pt;mso-padding-alt:0in 5.4pt 0in 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:32.2pt'>
  <td width=245 valign=top style='width:183.8pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;height:32.2pt'>
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
  normal'><i style='mso-bidi-font-style:normal'><span style='font-size:10.0pt'>Contract
  No</span></i>. </b><b style='mso-bidi-font-weight:normal'><span
  style='mso-fareast-language:KO'><o:p></o:p></span></b></p>
  </td>
 </tr>
</table>

<p class=MsoTitle align=left style='text-align:left'>CỘNG HÒA XÃ HỘI CHỦ NGHĨA
VIỆT NAM</p>

<h4 align=left style='text-align:left'><span style='font-weight:normal'><span
style='mso-spacerun:yes'>       </span>SOCIALIST <st1:PlaceType w:st="on">REPUBLIC</st1:PlaceType>
OF VIETNAM<o:p></o:p></span></h4>

<h2 align=left style='margin-left:4.5pt;text-align:left;text-indent:.5in'><span
style='mso-spacerun:yes'> </span>Độc lập – Tự do – Hạnh phúc</h2>

<h4 style='margin-left:1.0in;text-indent:.5in'><span style='font-weight:normal'>Independence
– Freedom - Happiness<o:p></o:p></span></h4>

<p class=MsoNormal align=center style='margin-left:1.0in;text-align:center;
text-indent:.5in'>-----------------------------------</p>

<p class=MsoNormal align=center style='text-align:center'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<h1><span style='font-size:12.0pt'>HỢP ĐỒNG LAO ĐỘNG<o:p></o:p></span></h1>

<p class=MsoNormal align=center style='text-align:center'><b><i>LABOUR CONTRACT<o:p></o:p></i></b></p>

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
tab-stops:4.75in'><i>We, one party to the contract, <b style='mso-bidi-font-weight:
normal'>Mr/Ms:</b><span style='mso-tab-count:1'>                                                      </span>Nationality:
Korean<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Chức vụ: <span style='mso-bidi-font-weight:bold'>Giám
đốc Hành Chính- Nhân Sự<o:p></o:p></span></p>

<h5 style='margin-left:.25in;text-indent:.25in;tab-stops:4.75in'><span
style='font-size:12.0pt'>Position:<span style='mso-spacerun:yes'>  </span>HR
&amp; GA Director<o:p></o:p></span></h5>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Đại diện cho :<span style='mso-spacerun:yes'> 
</span><b>Ngân hàng Shinhan Việt <st1:place w:st="on"><st1:country-region
 w:st="on">Nam</st1:country-region></st1:place> </b><b><span style='mso-fareast-language:
KO'>(</span>“Ngân hàng”)<span style='mso-tab-count:1'>      </span> </b>Điện
thoại: <span lang=FR style='mso-ansi-language:FR'>3 829 1581</span></p>

<p class=MsoNormal style='margin-left:.25in;text-align:justify;text-justify:
inter-ideograph;text-indent:.25in;tab-stops:4.75in'><i>On behalf of:</i><span
style='mso-spacerun:yes'>  </span><b style='mso-bidi-font-weight:normal'>Shinhan
Bank Vietnam </b><b style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:
KO'>(the “Bank”)</span></b><span style='mso-tab-count:1'>                </span>
<i style='mso-bidi-font-style:normal'>Telephone No.:<span style='mso-bidi-font-style:
italic'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.75in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Địa chỉ:<span style='mso-spacerun:yes'>  </span><span
lang=FR style='mso-ansi-language:FR'>138 Hai Bà Trưng, Q.1,<span
style='mso-spacerun:yes'>  </span>TPHCM</span><span style='mso-tab-count:1'>                                  </span></p>

<p class=MsoNormal style='margin-left:.25in;text-align:justify;text-justify:
inter-ideograph;text-indent:.25in;tab-stops:4.75in'><i>Address: 138 Hai Ba
Trung Str, Dist 1,<span style='mso-spacerun:yes'>  </span>HCM <span
style='mso-tab-count:1'>                            </span><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-justify:
inter-ideograph;tab-stops:4.75in'><span lang=FR style='mso-ansi-language:FR'>Và
một bên là <b style='mso-bidi-font-weight:normal'>Ông/Bà:<span
style='mso-spacerun:yes'>  </span><span style='mso-no-proof:yes'><%=dt_total.Rows[i]["full_name"].ToString() %></span></b><span
style='mso-tab-count:1'>                                                </span></span>Quốc
tịch:<span style='mso-tab-count:1'> </span><%=dt_total.Rows[i]["nation"].ToString() %></p>

<h3 style='tab-stops:4.75in'><span style='font-size:12.0pt'>And, the other party
to the contract, <b style='mso-bidi-font-weight:normal'>Mr/Ms:</b><span
style='mso-tab-count:1'>                                            </span>Nationality:<span
style='mso-tab-count:1'>           </span><o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Sinh ngày / Date of birth:<span
style='mso-spacerun:yes'>   </span><span style='mso-no-proof:yes'><%=dt_total.Rows[i]["birth_dt"].ToString() %></span><span
style='mso-tab-count:1'>          </span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Tại/ <i style='mso-bidi-font-style:normal'>In</i>:<span
style='mso-spacerun:yes'>  </span><span style='mso-no-proof:yes'><%=dt_total.Rows[i]["n_country2"].ToString() %></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Nghề nghiệp/ <i style='mso-bidi-font-style:normal'>Profession</i>:
<span style='mso-tab-count:2'>                   </span>Ngân hàng/ <i
style='mso-bidi-font-style:normal'>Banking </i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Địa chỉ thường trú/ <i>P. Address</i>: <span
style='mso-no-proof:yes'><%=dt_total.Rows[i]["permanent_addr"].ToString() %></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-spacerun:yes'> </span>Số CMND-Hộ
chiếu/<i><span style='mso-spacerun:yes'>  </span>ID card No- PP</i>: <span
style='mso-no-proof:yes'><%=dt_total.Rows[i]["person_id"].ToString() %></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style='mso-spacerun:yes'> </span>Cấp ngày<i>/</i><i
style='mso-bidi-font-style:normal'> i<span style='mso-bidi-font-style:italic'>ssued
on:</span></i> <span style='mso-no-proof:yes'><%=dt_total.Rows[i]["issue_dt"].ToString() %></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Tại/ <i style='mso-bidi-font-style:normal'>In</i>:<i
style='mso-bidi-font-style:normal'> <span style='mso-no-proof:yes'><%=dt_total.Rows[i]["place_per_id"].ToString() %></span><span
style='mso-spacerun:yes'>          </span><span style='mso-tab-count:1'>        </span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Số sổ Bảo hiểm xã hội (nếu có):<%=dt_total.Rows[i]["social_no"].ToString() %><span
style='mso-spacerun:yes'>                            </span>cấp ngày <%=dt_total.Rows[i]["social_dt"].ToString() %><span
style='mso-spacerun:yes'>                       </span>tại <%=dt_total.Rows[i]["social_place"].ToString() %></p>

<h3 style='margin-left:.25in;text-indent:.25in'>Number of the labour book (if
any):<span style='mso-spacerun:yes'>                          </span>issued
on<span style='mso-spacerun:yes'>                   </span>in<span
style='mso-spacerun:yes'>    </span><span style='mso-fareast-language:KO'><o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Mã số thuế thu nhập cá nhân (nếu có): <%=dt_total.Rows[i]["pit_tax_no"].ToString() %></p>

<h3 style='text-indent:.5in'>Personal income tax code (if any):</h3>

<p class=MsoNormal style='margin-top:12.0pt;text-align:justify;text-justify:
inter-ideograph'>Thỏa thuận ký kết hợp đồng lao động và cam kết làm đúng những
điều khoản sau đây:</p>

<h3><span style='font-size:12.0pt'>Agree to sign this labour contract, and
commit to comply with all the following provisions:<o:p></o:p></span></h3>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<h2>Điều 1: Thời hạn và công việc hợp đồng</h2>

<p class=MsoNormal><span style='mso-tab-count:3'>                                    </span><b><i><span
style='mso-spacerun:yes'>       </span>Article 1: Duration and type of
contractual work<o:p></o:p></i></b></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 2.5in 5.25in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Loại hợp đồng lao đồng :<span style='mso-tab-count:
1'>        </span>+ Hợp đồng với thời hạn xác định<span style='mso-tab-count:
1'>            </span><% if (contract_type == "04")
                          { %><!--[if supportFields]><span style='mso-element:field-begin'></span>
FORMCHECKBOX <span style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF6500000014000000000000000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><span
style='mso-spacerun:yes'> </span><%}
    else
    { %><!--[if supportFields]><span style='mso-element:
field-begin'></span><span style='mso-spacerun:yes'> </span>FORMCHECKBOX <span
style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF650000001400060043006800650063006B003100000001000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><%} %></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in;tab-stops:2.5in 5.25in'><i>Type of labour contract <span
style='mso-tab-count:1'>          </span>Definite term labour contract<o:p></o:p></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in;tab-stops:2.5in 5.25in'><i><span
style='mso-spacerun:yes'> </span><span style='mso-tab-count:1'>                                               </span>+
</i>Hợp đồng không xác định thời hạn <span style='mso-tab-count:1'>     </span><%if (contract_type != "04")
                                                                                   { %><!--[if supportFields]><span
style='mso-element:field-begin'></span><span
style='mso-spacerun:yes'> </span>FORMCHECKBOX <span style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF6500000014000000000000000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><span
style='mso-spacerun:yes'> </span><%}
    else
    { %><!--[if supportFields]><span style='mso-element:
field-begin'></span><span style='mso-spacerun:yes'> </span>FORMCHECKBOX <span
style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF650000001400060043006800650063006B003100000001000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><%} %></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:.5in;tab-stops:2.5in 5.25in'><span style='mso-tab-count:1'>                                                </span><i
style='mso-bidi-font-style:normal'>Indefinite term labour contract<o:p></o:p></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
tab-stops:2.5in 5.25in'><span style='mso-tab-count:1'>                                                            </span>+
Hợp đồng thời vụ <span style='mso-tab-count:1'>                                 </span><!--[if supportFields]><span
style='mso-element:field-begin'></span><span
style='mso-spacerun:yes'> </span>FORMCHECKBOX <span style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF650000001400060043006800650063006B003100000000000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><i><o:p></o:p></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
tab-stops:2.5in'><i><span style='mso-tab-count:1'>                                                            </span>Seasonal
labour contract<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Từ ngày/ <i style='mso-bidi-font-style:normal'>From
date</i>: <span style='mso-tab-count:1'>  </span><span style='mso-no-proof:
yes'><%=dt_total.Rows[i]["begin_contract"].ToString() %></span><span style='mso-tab-count:2'>                  </span><span
style='mso-fareast-language:KO'>đ</span>ến ngày/ <i style='mso-bidi-font-style:
normal'>to date</i>:<span style='mso-spacerun:yes'>  </span><span
style='mso-spacerun:yes'> </span><span style='mso-no-proof:yes'><%=dt_total.Rows[i]["end_contract"].ToString() %></span> <%if (contract_type == "04")
                                                                                                 { %>không xác định thời hạn<%} %></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph'>(đối
với hợp đồng xác định thời hạn và thời vụ/<i style='mso-bidi-font-style:normal'>with
respect to definite term or seasonal labour contract)</i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Thử việc từ ngày<span style='mso-spacerun:yes'> 
</span><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'> </span></span><span
style='mso-spacerun:yes'> </span>tháng<span style='mso-spacerun:yes'>  </span><span
style='mso-fareast-language:KO'><span style='mso-spacerun:yes'>  </span></span><span
style='mso-spacerun:yes'>   </span>năm <span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'> </span></span><span
style='mso-spacerun:yes'>   </span>đến ngày <span style='mso-fareast-language:
KO'><span style='mso-spacerun:yes'>    </span></span>tháng<span
style='mso-spacerun:yes'>   </span><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'> </span></span><span
style='mso-spacerun:yes'> </span>năm<span style='mso-fareast-language:KO'> </span><span
style='mso-spacerun:yes'>  </span></p>

<h3><span style='font-size:12.0pt'><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>Probation period starts from <span
style='mso-tab-count:3'>                          </span><span
style='mso-spacerun:yes'>        </span>to.<span style='mso-spacerun:yes'> 
</span><o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Địa điểm làm việc : <b style='mso-bidi-font-weight:
normal'><span lang=FR style='mso-ansi-language:FR'>Văn phòng Shinhan Việt Nam
hoặc các chi nhánh hoặc địa điểm trực thuộc của ngân hàng TNHH MTV Shinhan Việt
Nam</span></b><span lang=FR style='mso-ansi-language:FR'><span
style='mso-spacerun:yes'>      </span></span><i><o:p></o:p></i></p>

<h5><span style='font-size:12.0pt'><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>Place of work:<span style='mso-tab-count:
2'>             </span><o:p></o:p></span></h5>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in left 4.0in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Chức danh chuyên môn: <b style='mso-bidi-font-weight:
normal'>Nhân viên kinh doanh </b><span style='mso-tab-count:2'>                 </span>Phòng/bộ
phận: Thẻ<b><o:p></o:p></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
tab-stops:.5in 4.0in'><i><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>Professional title: Employee:<span
style='mso-spacerun:yes'>  </span>Sales Agent<span style='mso-tab-count:2'>                              </span>Dept/Sect:<span
style='mso-spacerun:yes'>  </span>Card<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Công việc phải làm:<span
style='mso-spacerun:yes'>  </span>tiếp thị và bán sản phẩm (chi tiết <span
lang=FR style='mso-ansi-language:FR'>theo bản mô tả công việc đính kèm)</span></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i>Jobs to be carried out:<span style='mso-spacerun:yes'> 
</span>marketing &amp; sales the Bank’s product- details as Job Description
attached.<o:p></o:p></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<h2>Điều 2: Chế độ làm việc</h2>

<p class=MsoNormal><span style='mso-tab-count:4'>                                                </span><span
style='mso-spacerun:yes'>         </span><b><i>Article 2: Working condition</i></b><span
style='mso-tab-count:3'>                             </span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Thời giờ làm việc :<span style='mso-tab-count:
1'>      </span><!--[if supportFields]><span style='mso-element:field-begin'></span>
FORMCHECKBOX <span style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF650000001400060043006800650063006B003100000000000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><span
style='mso-spacerun:yes'>  </span><span style='mso-bidi-font-weight:bold'>8:00
sáng<span style='mso-spacerun:yes'>  </span>– </span><span style='mso-fareast-language:
KO;mso-bidi-font-weight:bold'>5</span><span style='mso-bidi-font-weight:bold'>:00
chiều từ thứ 2 đến thứ 6<b><o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i>Working hours:<span style='mso-spacerun:yes'>          
</span></i><!--[if supportFields]><span style='mso-element:field-begin'></span><span
style='mso-spacerun:yes'> </span>FORMCHECKBOX <span style='mso-element:field-separator'></span><![endif]--><!--[if gte mso 9]><xml>
 <w:data>FFFFFFFF650000001400060043006800650063006B003100000000000000000000000000000000000000000000000000</w:data>
</xml><![endif]--><!--[if supportFields]><span style='mso-element:field-end'></span><![endif]--><span
style='mso-spacerun:yes'>  </span><i>8:00 am- 5:00 pm; from Monday to Friday<o:p></o:p></i></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i><span style='mso-tab-count:2'>                        </span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Được cấp phát những dụng cụ làm việc gồm: <span
style='mso-bidi-font-weight:bold'>Được cung cấp các dụng cụ cần thiết phục vụ
cho công việc Ngân hàng để nhân viên có thể hoàn thành công việc một cách có hiệu
quả nhất. Nhân viên phải có trách nhiệm bảo quản, giữ gìn trang thiết bị ở điều
kiện tốt nhất.</span></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i>Equipment to be received includes necessary facilities
required for the employee to efficiently complete his/her job. The employee
must maintain and keep the equipment in good condition.<o:p></o:p></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<h2>Điều 3: Nghĩa vụ và quyền lợi của người lao động</h2>

<p class=MsoNormal style='margin-left:1.0in'><span
style='mso-spacerun:yes'>      </span><span style='mso-tab-count:1'>      </span><span
style='mso-spacerun:yes'>  </span><b><i>Article 3: Obligations, rights and
benefits of the employee<o:p></o:p></i></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph;text-indent:-.25in;mso-list:l2 level2 lfo1;tab-stops:list .5in'><![if !supportLists]><b><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>1.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b>Quyền
lợi / </b><i>Rights and benefits</i><b><o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Phương tiện đi lại, làm việc : <span
style='mso-bidi-font-weight:bold'>tự túc</span> </p>

<h5><span style='font-size:12.0pt'><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>Transportation and working means: by
the employee’s means<span style='mso-tab-count:1'>          </span><o:p></o:p></span></h5>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Mức lương chính hoặc tiền công <span
style='mso-fareast-language:KO'><span style='mso-spacerun:yes'> </span>:</span><span
style='mso-bidi-font-weight:bold'><span style='mso-spacerun:yes'>   </span><b><span
style='mso-no-proof:yes'>3,745,000</span></b></span><span style='mso-fareast-language:
KO;mso-bidi-font-weight:bold'>VNĐ </span><span style='mso-bidi-font-weight:
bold'>/ tháng<b>/</b><i style='mso-bidi-font-style:normal'>month</i></span><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO;
mso-bidi-font-weight:bold'> </span></i><b><o:p></o:p></b></p>

<h3><span style='font-size:12.0pt'><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>Basic salary or wage:<span
style='mso-tab-count:1'> </span><o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Hình thức trả lương:<span
style='mso-spacerun:yes'>      </span><span style='mso-bidi-font-weight:bold'>Trả
01 lần trong tháng</span> </p>

<h3><span style='font-size:12.0pt'><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>Method of payment:<span
style='mso-spacerun:yes'>     </span>Once a month <o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Phụ cấp chức vụ &amp; phụ cấp công việc theo quy
định của Ngân hàng.<i><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph'><span
style='mso-spacerun:yes'> </span><i>Job Title Allowance &amp; </i><i><span
style='mso-fareast-language:KO'><span style='mso-spacerun:yes'> </span>Job
Allowance are stipulated by the Bank regulations.</span><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-style:italic'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Tiền thưởng doanh thu (chỉ áp dụng đối với bộ phận
kinh doanh thẻ): chi tiết theo kết quả công việc và quy chế trả thưởng của Ngân
hàng đính kèm.<i><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph'><i
style='mso-bidi-font-style:normal'>Commission (only granted for sales agent):</i><i><span
style='mso-fareast-language:KO'> based on sales performance as the Bank salary
scheme attached.</span><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Được trả lương vào các ngày<b> 21 </b>hàng tháng</p>

<h3><span style='font-size:12.0pt'><span style='mso-spacerun:yes'>  </span><span
style='mso-tab-count:1'>          </span>To be paid monthly on the 21<sup>st</sup>
each month<o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Chế độ nâng lương: <span style='mso-bidi-font-weight:
bold'>Theo quyết định của Ban Giám Đốc</span> </p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i>Pay rise policy: As determined by the Board of Directors </i><i><span
style='mso-fareast-language:KO'><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Chế độ nghỉ ngơi: <span style='mso-bidi-font-weight:
bold'>Theo Luật Lao Động hiện hành của Việt <st1:place w:st="on"><st1:country-region
 w:st="on">Nam</st1:country-region></st1:place> và “Nội Quy Lao Động” hiện hành
của Ngân hàng<span style='mso-tab-count:1'>       </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i>Holidays (weekend, annual leave, public holidays etc</i><i><span
style='mso-fareast-language:KO'>.</span>): As per the labour laws and internal
labour rules of the Bank<span style='mso-tab-count:1'>      </span><o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Bảo hiểm xã hội, bảo hiểm y tế và bảo hiểm thất
nghiệp : <span style='mso-bidi-font-weight:bold'>Theo Luật hiện hành của Việt <st1:place
w:st="on"><st1:country-region w:st="on">Nam</st1:country-region></st1:place><b>
<o:p></o:p></b></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph'><i
style='mso-bidi-font-style:normal'>Social, Health insurance and Unempoyment
insurance: As per the laws of Vietnam<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:12.0pt;margin-right:0in;margin-bottom:
0in;margin-left:1.0in;margin-bottom:.0001pt;text-align:justify;text-justify:
inter-ideograph;text-indent:-.25in;mso-list:l2 level2 lfo1;tab-stops:list 1.0in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>1.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]>BHXH<i
style='mso-bidi-font-style:normal'> (Social Insurance):</i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.25in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:.5in'>Người sử dụng lao động <i style='mso-bidi-font-style:normal'>(Employer
pays</i>) : 18%<span style='mso-tab-count:2'>             </span>Người lao động
<i style='mso-bidi-font-style:normal'>(employee)</i>: 8%</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:1.0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level2 lfo1;tab-stops:list 1.0in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>2.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]>BHYT
<i style='mso-bidi-font-style:normal'>(Health Insurance):</i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.25in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:.5in'>Người sử dụng lao động <i style='mso-bidi-font-style:normal'>(Employer
pays</i>) : 3%<span style='mso-tab-count:1'>   </span><span
style='mso-spacerun:yes'>          </span>Người lao động <i style='mso-bidi-font-style:
normal'>(employee</i>): 1.5%</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:1.0in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level2 lfo1;tab-stops:list 1.0in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>3.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]>Unemployment
Insurance (BHTN):</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:.25in'>Người sử dụng lao động <i style='mso-bidi-font-style:normal'>(Employer
pays</i>) : 1%<span style='mso-tab-count:1'>   </span><span
style='mso-spacerun:yes'>          </span>Người lao động <i style='mso-bidi-font-style:
normal'>(employee)</i>: 1%</p>

<p class=MsoNormal style='margin-top:6.0pt;text-align:justify;text-justify:
inter-ideograph'>Tỉ lệ này sẽ tự động thay đổi theo Luật hiện hành của Việt <st1:place
w:st="on"><st1:country-region w:st="on">Nam</st1:country-region></st1:place>
trong trường hợp có sự điều chỉnh theo luật. <i style='mso-bidi-font-style:
normal'>(This rate will be changed automatically as per current laws of <st1:place
w:st="on"><st1:country-region w:st="on">Vietnam</st1:country-region></st1:place>
in case there is any amendment issued)<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
lang=EN-GB style='mso-fareast-font-family:"Times New Roman";mso-ansi-language:
EN-GB'><span style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=EN-GB style='mso-ansi-language:EN-GB'>Chế
độ đào tạo : <span style='mso-bidi-font-weight:bold'>Được huấn luyện về công việc
và các khoá học khác để phát triển khi cần</span> <span style='mso-bidi-font-weight:
bold'>thiết</span> <o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><i>Trainning policy: The training will be conducted to improve
the employee’s skill where necessary <o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-bidi-font-weight:bold'><span
style='mso-list:Ignore'>-<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Những thỏa thuận khác: Không có<span
style='mso-tab-count:1'>     </span><b><o:p></o:p></b></p>

<p class=MsoBodyText2 style='margin-left:.5in'><b><span
style='mso-spacerun:yes'> </span></b><i>Other agreements: None</i></p>

<p class=MsoBodyText2 style='margin-left:.5in'><i><span style='mso-tab-count:
3'>                                    </span></i></p>

<ol style='margin-top:0in' start=2 type=1>
 <li class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
     mso-list:l1 level1 lfo7;tab-stops:list .5in'><b>Nghĩa vụ /</b><i>Obligations:<o:p></o:p></i></li>
</ol>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Hoàn thành những công việc đã cam kết trong hợp
đồng lao động.</p>

<h3><span style='font-size:12.0pt'><span style='mso-spacerun:yes'> </span><span
style='mso-tab-count:1'>           </span><span
style='mso-spacerun:yes'> </span>To fulfill the committed contractual tasks in
this labour contract<o:p></o:p></span></h3>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Chấp hành lệnh điều hành sản xuất – kinh doanh,
nội quy lao động của Ngân hàng</p>

<p class=MsoBodyText style='margin-left:.5in;text-indent:-.5in'><span
style='mso-spacerun:yes'>   </span><span style='mso-tab-count:1'>         </span>To
comply with business and administration policies, internal labour rules<span
style='mso-fareast-language:KO'> of the Bank<o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Bồi thường vi phạm và vật chất : Theo luật Việt <st1:place
w:st="on"><st1:country-region w:st="on">Nam</st1:country-region></st1:place> và
nội qui lao động của Ngân hàng</p>

<p class=MsoBodyText style='margin-left:.5in;text-indent:3.0pt'>Compensation
for violations and material damages: As per the law of Vietnam and internal labour
rules of the <span style='mso-fareast-language:KO'>B</span>ank. <span
style='mso-fareast-language:KO'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Người lao động có nghĩa vụ kịp thời thông báo
cho Phòng Nhân sự của Ngân hàng những thay đổi về cá nhân như nhân thân, địa chỉ
thường trú/ tạm trú dài hạn, trình độ học vấn, sức khỏe và các thông tin cá
nhân có liên quan khác được đề cập trong Hợp đồng lao động và các phụ lục Hợp đồng
lao động</p>

<p class=MsoNormal style='margin-top:0in;margin-right:0in;margin-bottom:6.0pt;
margin-left:.5in;text-align:justify;text-justify:inter-ideograph;line-height:
12.0pt;tab-stops:.25in;layout-grid-mode:char;mso-layout-grid-align:none'><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO'>The
employee is obligated to inform in due course to the HR Dept. of Bank of any
changes with regards to personal records and status such as
permanent/registered address, health status, education status and other
relevant personal data which are written on the Labor contract and all Annexes
to the Labor contract</span></i><span style='mso-fareast-language:KO'>.<i
style='mso-bidi-font-style:normal'><o:p></o:p></i></span></p>

<p class=MsoBodyText style='margin-left:.5in;text-indent:3.0pt'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<h2>Điều 4: Nghĩa vụ và quyền hạn của người sử dụng lao động</h2>

<h3 style='tab-stops:112.5pt 1.75in'><span style='font-size:12.0pt'><span
style='mso-tab-count:2'>                                          </span><span
style='mso-spacerun:yes'> </span><b>Article 4: Obligations and rights of the
Employer<o:p></o:p></b></span></h3>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph;text-indent:-.25in;mso-list:l6 level1 lfo8;tab-stops:list .5in'><![if !supportLists]><b><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>1.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span></b><![endif]><b>Nghĩa
vụ/ </b><i>Obligations:</i><b><o:p></o:p></b></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Bảo đảm việc làm và thực hiện đầy đủ những điều
đã cam kết trong hợp đồng lao động.</p>

<p class=MsoBodyTextIndent style='margin-left:.5in'>To ensure jobs and fully
comply with the terms and conditions in accordance the labour contract</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Thanh toán đầy đủ, đúng thời hạn các chế độ và
quyền lợi cho người lao động theo hợp đồng lao động, thỏa ước lao động tập thể
(nếu có).</p>

<p class=MsoBodyText style='margin-left:.5in'><span
style='mso-spacerun:yes'> </span>To fully and timely pay the employee all
remuneration and other benefits in accordance with the labour contract or
collective labour agreement (if any)</p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b><o:p>&nbsp;</o:p></b></p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph;text-indent:-.25in;mso-list:l6 level1 lfo8;tab-stops:list .5in'><![if !supportLists]><b
style='mso-bidi-font-weight:normal'><span style='mso-fareast-font-family:"Times New Roman"'><span
style='mso-list:Ignore'>2.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span></b><![endif]><b>Quyền hạn/</b>Rights:</p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Điều hành người lao động hoàn thành công việc
theo hợp đồng (bố trí, điều chuyển, tạm ngừng việc)</p>

<p class=MsoNormal style='margin-left:.5in;text-align:justify;text-justify:
inter-ideograph'><span style='mso-spacerun:yes'> </span><i>To manage the
employee to fulfill the jobs under labour contract (arrangement, transfer and
suspension of jobs etc</i><i><span style='mso-fareast-language:KO'>.</span>)<o:p></o:p></i></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Tạm hoãn, chấm dứt hợp đồng lao động, kỷ luật
người lao động theo quy định của pháp luật, thỏa ước lao động tập thể (nếu có)
và nội quy lao động của Ngân hàng.</p>

<p class=MsoBodyText style='margin-left:.5in'><span
style='mso-spacerun:yes'> </span>To suspend, terminate the labour contract and
apply disciplinary measures in accordance with the provisions of the Labour
Code, the collective labour agreement (if any) and internal labour regulations
of the <span style='mso-fareast-language:KO'>B</span>ank.</p>

<h2><o:p>&nbsp;</o:p></h2>

<h2>Điều 5: Điều khoản thi hành</h2>

<h3><span style='font-size:12.0pt'><span style='mso-tab-count:4'>                                                </span><b><span
style='mso-spacerun:yes'>   </span>Article 5: Implementation provision<o:p></o:p></b></span></h3>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Những vấn đề về lao động không ghi trong hợp đồng
này thì áp dụng qui định của nội qui lao động của Ngân hàng và pháp luật lao động.</p>

<p class=MsoBodyText style='margin-left:.5in'>For labour issues which are not
stated in this labour contract, the provisions of the internal labour rules<span
style='mso-fareast-language:KO'> of the Bank</span> shall apply. </p>

<p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-justify:inter-ideograph;
text-indent:-.25in;mso-list:l2 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman"'><span style='mso-list:Ignore'>-<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]>Hợp đồng lao động được lập thành 02 bản có giá
trị ngang nhau, mỗi bên giữ một bản và có hiệu lực từ ngày <span
style='mso-no-proof:yes'>16/08/2016</span>. Khi hai bên ký kết phụ lục hợp đồng
lao động thì nội dung của phụ lục hợp đồng lao đồng cũng có giá trị như các nội
dung của bản hợp đồng lao động này.</p>

<p class=MsoBodyText style='margin-left:.5in'>The labour contracts are made in
duplicate with equal validity, each party retaining one original.<span
style='mso-spacerun:yes'>  </span>The labour contracts come into effect on <span
style='mso-no-proof:yes'>16/08/2016</span> where any addendum to this contract
is concluded by parties, such addendum has the same validity as this labour
contract.</p>

<p class=MsoBodyText style='margin-left:.5in'><o:p>&nbsp;</o:p></p>

<p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Hợp
đồng này lập tại TP HCM, ngày<span style='mso-spacerun:yes'>  </span><span
style='mso-no-proof:yes'>15/08/2016</span><span
style='mso-spacerun:yes'>          </span></span><span style='mso-fareast-language:
KO;font-style:normal;mso-bidi-font-style:italic'><o:p></o:p></span></p>

<p class=MsoBodyText>This labour contract is signed in HCMC, date <span
style='mso-no-proof:yes'>15/08/2016</span></p>

<p class=MsoBodyText><o:p>&nbsp;</o:p></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width=662
 style='width:6.9in;margin-left:.2in;border-collapse:collapse;mso-yfti-tbllook:
 480;mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=288 valign=top style='width:3.0in;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoBodyText><span style='font-style:normal;mso-bidi-font-style:italic'>Người
  lao động<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'>Employee<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal'>Chữ ký/</span><span
  style='mso-bidi-font-style:normal'>Signature: <span style='mso-tab-count:
  1'>      </span>______________<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'>Tên/name: <o:p></o:p></span></p>
  <p class=MsoBodyText><o:p>&nbsp;</o:p></p>
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
  ký/signature: <span style='mso-tab-count:1'>       </span></span><span
  style='mso-bidi-font-style:normal'>______________<o:p></o:p></span></p>
  <p class=MsoBodyText><span style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoBodyText><span style='font-style:normal'>Tên</span><span
  style='mso-bidi-font-style:normal'>/name: <span style='mso-tab-count:2'>                  </span></span><b
  style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:KO;
  font-style:normal'>LEE WON SUK</span></b><span style='mso-fareast-language:
  KO;mso-bidi-font-style:normal'><o:p></o:p></span></p>
  <p class=MsoBodyText><b style='mso-bidi-font-weight:normal'><span
  style='mso-bidi-font-style:normal'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoBodyText><span style='font-style:normal'>Chức vụ</span><span
  style='mso-bidi-font-style:normal'>/position: </span><span style='mso-fareast-language:
  KO;mso-bidi-font-style:normal'><span style='mso-spacerun:yes'>      </span>HR
  &amp; GA</span><span style='mso-bidi-font-style:normal'> Director </span><span
  style='font-style:normal;mso-bidi-font-style:italic'><o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoTitle align=left style='text-align:left'><span style='mso-fareast-language:
KO'><o:p>&nbsp;</o:p></span></p>

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
    }
     %>
	 
</div>

</body>

</html>
