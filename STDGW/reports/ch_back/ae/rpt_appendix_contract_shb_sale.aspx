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
    string l_labour_contract_pk;
    l_labour_contract_pk = Request["emp_pk"].ToString(); // pk cua table labour contract

    string SQL
 = "select to_char(to_date(b.signature_date, 'yyyymmdd'), 'dd/mm/yyyy') signature_date, " +
        "       b.appendix_no as appendix_no, " +
        "       a.full_name as full_name, " +
        "       (select code_fnm " +
        "        from vhr_hr_code v " +
        "        where a.nation = v.code and id = 'HR0009') " +
        "           nation, " +
        "       decode(length(a.birth_dt), 4, a.birth_dt, to_char(to_date(a.birth_dt, 'yyyymmdd'), 'dd-mm-yyyy')) birth_dt, " +
        "       a.permanent_addr, " +
        "       a.person_id, " +
        "       to_char(to_date(a.issue_dt, 'yyyymmdd'), 'dd-mm-yyyy') issue_dt, " +
        "       (select code_nm " +
        "        from vhr_hr_code v " +
        "        where a.place_per_id = v.code and id = 'HR0014') " +
        "           place_per_id, " +
        "       to_char(to_date(b.signature_date, 'yyyymmdd') - 1, 'dd mm yyyy') signature_date2, " +
        "       to_char(to_date(b.signature_date, 'yyyymmdd') - 1, 'dd Mon yyyy') signature_date3, " +
        "       to_char(to_date(b.signature_date, 'yyyymmdd'), 'dd Mon yyyy') signature_date4, " +
        "       to_char(nvl(d.basic_sal, nvl(c.basic_sal, 0)), '99,999,999') as old_sal, " +
        "       to_char(nvl(b.basic_sal, 0), '99,999,999') as new_sal, " +
        "       c.contract_no, " +
        "       to_char(to_date(c.begin_contract, 'yyyymmdd'), 'dd-mm-yyyy') begin_contract " +
        "from thr_employee a, thr_appendix_contract b, thr_labour_contract c, thr_appendix_contract d " +
        "where     a.del_if = 0 " +
        "      and b.del_if = 0 " +
        "      and c.del_if = 0 " +
        "      and d.del_if(+) = 0 " +
        "      and a.pk = c.thr_employee_pk " +
        "      and b.thr_employee_pk = d.thr_employee_pk(+) " +
        "      and b.thr_employee_pk = c.thr_employee_pk " +
        "      and b.thr_labour_contract_pk = d.thr_labour_contract_pk(+) " +
        "      and (b.appendix_times - 1) = d.appendix_times(+) " +
        "      and b.thr_labour_contract_pk = c.pk " +
        "      and c.pk in (" + l_labour_contract_pk + ") " ;

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
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 15">
<meta name=Originator content="Microsoft Word 15">
<link rel=File-List href="rpt_appendix_contract_shb_sale_files/filelist.xml">
<title>CỘNG HÒA XÀ HỘI CHỦ NGHĨA VIỆT NAM</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="City"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="country-region"/>
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:Description>.                                                                   최초 생성자ID : S001_16607619 &#13;&#10;최초 문서생성 시간 : 2016-09-09 15:54:04 &#13;&#10;암호화 해제 사용자ID : S001_12502146&#13;&#10;해제 시간 : 2016-11-29 12:09 &#13;&#10;복호화 수행 PC IP : 10.95.13.130 &#13;&#10;복호화 수행 PC MAC : 082E5F15B59B;</o:Description>
  <o:LastAuthor>DEV04</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>18</o:TotalTime>
  <o:LastPrinted>2015-06-25T10:45:00Z</o:LastPrinted>
  <o:Created>2016-12-11T08:53:00Z</o:Created>
  <o:LastSaved>2016-12-11T08:53:00Z</o:LastSaved>
  <o:Pages>2</o:Pages>
  <o:Words>579</o:Words>
  <o:Characters>3301</o:Characters>
  <o:Company>HOME</o:Company>
  <o:Lines>27</o:Lines>
  <o:Paragraphs>7</o:Paragraphs>
  <o:CharactersWithSpaces>3873</o:CharactersWithSpaces>
  <o:Version>15.00</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<link rel=dataStoreItem href="rpt_appendix_contract_shb_sale_files/item0001.xml"
target="rpt_appendix_contract_shb_sale_files/props002.xml">
<link rel=themeData href="rpt_appendix_contract_shb_sale_files/themedata.thmx">
<link rel=colorSchemeMapping
href="rpt_appendix_contract_shb_sale_files/colorschememapping.xml">
<!--[if gte mso 9]><xml>
 <w:WordDocument>
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
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   QFormat="true" Name="heading 5"/>
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
	mso-font-alt:"Arial Unicode MS";
	mso-font-charset:129;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:0 151388160 16 0 524288 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1107305727 0 0 415 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520081665 -1073717157 41 0 66047 0;}
@font-face
	{font-family:Cambria;
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1073743103 0 0 415 0;}
@font-face
	{font-family:"\@Batang";
	panose-1:0 0 0 0 0 0 0 0 0 0;
	mso-font-charset:129;
	mso-generic-font-family:auto;
	mso-font-format:other;
	mso-font-pitch:fixed;
	mso-font-signature:0 151388160 16 0 524288 0;}
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
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-unhide:no;
	mso-style-link:"Header Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.25in right 6.5in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;
	mso-ansi-language:X-NONE;
	mso-fareast-language:X-NONE;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-link:"Footer Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	tab-stops:center 3.25in right 6.5in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	mso-fareast-font-family:Batang;
	mso-ansi-language:X-NONE;
	mso-fareast-language:X-NONE;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-unhide:no;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:"Tahoma",sans-serif;
	mso-fareast-font-family:Batang;
	mso-bidi-font-family:"Times New Roman";
	mso-ansi-language:X-NONE;
	mso-fareast-language:X-NONE;}
span.HeaderChar
	{mso-style-name:"Header Char";
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-parent:"";
	mso-style-link:Header;
	mso-ansi-font-size:12.0pt;
	mso-bidi-font-size:12.0pt;}
span.FooterChar
	{mso-style-name:"Footer Char";
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-parent:"";
	mso-style-link:Footer;
	mso-ansi-font-size:12.0pt;
	mso-bidi-font-size:12.0pt;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-parent:"";
	mso-style-link:"Balloon Text";
	mso-ansi-font-size:8.0pt;
	mso-bidi-font-size:8.0pt;
	font-family:"Tahoma",sans-serif;
	mso-ascii-font-family:Tahoma;
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;}
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
	{mso-footnote-separator:url("rpt_appendix_contract_shb_sale_files/header.htm") fs;
	mso-footnote-continuation-separator:url("rpt_appendix_contract_shb_sale_files/header.htm") fcs;
	mso-endnote-separator:url("rpt_appendix_contract_shb_sale_files/header.htm") es;
	mso-endnote-continuation-separator:url("rpt_appendix_contract_shb_sale_files/header.htm") ecs;}
@page WordSection1
	{size:595.45pt 841.7pt;
	margin:1.0in .6in 1.0in .6in;
	mso-header-margin:.5in;
	mso-footer-margin:1.45pt;
	mso-page-numbers:1;
	mso-footer:url("rpt_appendix_contract_shb_sale_files/header.htm") f1;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
@page WordSection2
	{size:595.45pt 841.7pt;
	margin:1.0in .6in 1.0in .6in;
	mso-header-margin:.5in;
	mso-footer-margin:1.45pt;
	mso-footer:url("rpt_appendix_contract_shb_sale_files/header.htm") f2;
	mso-paper-source:0;}
div.WordSection2
	{page:WordSection2;}
 /* List Definitions */
 @list l0
	{mso-list-id:1164514288;
	mso-list-type:hybrid;
	mso-list-template-ids:266897022 -1435497716 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:46.35pt;
	mso-level-number-position:left;
	margin-left:46.35pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-upper;
	mso-level-tab-stop:68.35pt;
	mso-level-number-position:left;
	margin-left:68.35pt;
	text-indent:-20.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:88.35pt;
	mso-level-number-position:right;
	margin-left:88.35pt;
	text-indent:-20.0pt;}
@list l0:level4
	{mso-level-tab-stop:108.35pt;
	mso-level-number-position:left;
	margin-left:108.35pt;
	text-indent:-20.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-upper;
	mso-level-tab-stop:128.35pt;
	mso-level-number-position:left;
	margin-left:128.35pt;
	text-indent:-20.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:148.35pt;
	mso-level-number-position:right;
	margin-left:148.35pt;
	text-indent:-20.0pt;}
@list l0:level7
	{mso-level-tab-stop:168.35pt;
	mso-level-number-position:left;
	margin-left:168.35pt;
	text-indent:-20.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-upper;
	mso-level-tab-stop:188.35pt;
	mso-level-number-position:left;
	margin-left:188.35pt;
	text-indent:-20.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:208.35pt;
	mso-level-number-position:right;
	margin-left:208.35pt;
	text-indent:-20.0pt;}
@list l1
	{mso-list-id:1615987185;
	mso-list-type:hybrid;
	mso-list-template-ids:1895327844 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:82.35pt;
	mso-level-number-position:left;
	margin-left:82.35pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:118.35pt;
	mso-level-number-position:left;
	margin-left:118.35pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:154.35pt;
	mso-level-number-position:left;
	margin-left:154.35pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:190.35pt;
	mso-level-number-position:left;
	margin-left:190.35pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:226.35pt;
	mso-level-number-position:left;
	margin-left:226.35pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:262.35pt;
	mso-level-number-position:left;
	margin-left:262.35pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:298.35pt;
	mso-level-number-position:left;
	margin-left:298.35pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:334.35pt;
	mso-level-number-position:left;
	margin-left:334.35pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:370.35pt;
	mso-level-number-position:left;
	margin-left:370.35pt;
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
<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt;
page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><b><span style='font-size:11.0pt;letter-spacing:1.4pt;mso-fareast-language:
KO'>CỘNG HÒA XÀ HỘI CHỦ NGHĨA VIỆT <st1:place w:st="on"><st1:country-region
 w:st="on">NAM</st1:country-region></st1:place><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='margin-bottom:6.0pt;text-align:center;
line-height:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><b><span style='font-size:11.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO'>Độc lập-Tự do-Hạnh phúc<o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt;
page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><i style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;
letter-spacing:1.4pt;mso-fareast-language:KO;mso-bidi-font-weight:bold'>SOCIALIST
REPUBLIC OF VIETNAM<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt;
page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><st1:place w:st="on"><st1:City w:st="on"><i style='mso-bidi-font-style:
  normal'><span style='font-size:11.0pt;letter-spacing:1.4pt;mso-fareast-language:
  KO;mso-bidi-font-weight:bold'>Independence</span></i></st1:City></st1:place><i
style='mso-bidi-font-style:normal'><span style='font-size:11.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO;mso-bidi-font-weight:bold'> – Freedom – Happiness<o:p></o:p></span></i></p>

<p class=MsoNormal align=center style='text-align:center;line-height:12.0pt;
page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><b><span style='font-size:11.0pt;letter-spacing:1.4pt;mso-fareast-language:
KO'>---***---<o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:29.1pt;mso-para-margin-left:2.25gd;
text-align:justify;text-justify:inter-ideograph;text-indent:-2.1pt;mso-char-indent-count:
-.17;line-height:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><b><span style='font-size:11.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO'><span style='mso-tab-count:8'>                                                  </span><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:29.1pt;mso-para-margin-left:2.25gd;
text-align:justify;text-justify:inter-ideograph;text-indent:-2.1pt;mso-char-indent-count:
-.17;line-height:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><b><span style='font-size:11.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO'><span style='mso-tab-count:8'>                                                  </span></span></b><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO'>TP.Hồ
Chí Minh</span></i><span style='mso-fareast-language:KO'>, ngày <span
style='mso-spacerun:yes'> </span><span style='color:red'><%=dt_total.Rows[i]["signature_date"].ToString() %><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:29.1pt;mso-para-margin-left:2.25gd;
text-align:justify;text-justify:inter-ideograph;text-indent:-2.1pt;mso-char-indent-count:
-.17;line-height:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><span style='font-size:11.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO;mso-bidi-font-weight:bold'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
mso-line-height-alt:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><b><span style='font-size:14.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
mso-line-height-alt:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><b><span style='font-size:14.0pt;letter-spacing:
1.4pt;mso-fareast-language:KO'>SHINHAN BANK VIET NAM LTD</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-fareast-language:
KO'><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:29.15pt;text-align:justify;text-justify:
inter-ideograph;text-indent:-29.15pt;mso-char-indent-count:-2.43;line-height:
12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><b style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:
KO'>NO/</span></b><i style='mso-bidi-font-style:normal'><span style='mso-fareast-language:
KO'>Số:</span></i><b style='mso-bidi-font-weight:normal'><span
style='mso-fareast-language:KO'><span style='mso-spacerun:yes'>   </span><span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["appendix_no"].ToString() %></span><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:
char;mso-layout-grid-align:none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center;mso-line-height-alt:
12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><b><span style='font-size:14.0pt;letter-spacing:1.4pt;mso-fareast-language:
KO'>PHỤ LỤC </span></b><b><span style='font-size:14.0pt;letter-spacing:1.4pt'>HỢP
ĐỒNG LAO ĐỘNG</span></b><b><span style='font-size:14.0pt;letter-spacing:1.4pt;
mso-fareast-language:KO'><o:p></o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;mso-line-height-alt:
12.0pt;page-break-after:avoid;tab-stops:-.5in;layout-grid-mode:char;mso-layout-grid-align:
none'><b><i style='mso-bidi-font-style:normal'><span style='font-size:14.0pt;
letter-spacing:1.4pt;mso-fareast-language:KO'>LABOUR CONTRACT’S ANNEX<o:p></o:p></span></i></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Chúng tôi, một bên là Ông/Bà: <span
style='mso-tab-count:1'>          </span><b style='mso-bidi-font-weight:normal'><span
style='mso-fareast-language:KO'>Lee Won Suk</span></b><span style='mso-tab-count:
1'> </span><span style='mso-spacerun:yes'>    </span><span style='mso-tab-count:
1'>        </span>Quốc tịch:<span style='mso-fareast-language:KO'> <span
style='mso-tab-count:1'>      </span>Hàn Quốc<o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;
layout-grid-mode:char;mso-layout-grid-align:none'><i style='mso-bidi-font-style:
normal'><span style='mso-fareast-language:KO'>We are, from one side,<span
style='mso-tab-count:1'> </span><span style='mso-spacerun:yes'>       </span>Mr.
Lee Won Suk<span style='mso-tab-count:2'>              </span> Nationality:
Republic of Korea<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Chức vụ:<span style='mso-fareast-language:KO'> <span
style='mso-spacerun:yes'> </span><span style='mso-tab-count:2'>                   </span><span
style='mso-tab-count:1'>            </span><span
style='mso-spacerun:yes'> </span>Giám đốc Hành Chính- Nhân sự<o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;
layout-grid-mode:char;mso-layout-grid-align:none'><i style='mso-bidi-font-style:
normal'><span style='mso-fareast-language:KO'>Position: <span style='mso-tab-count:
3'>                                 </span>HR- GA Director<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Đại diện cho:<span style='mso-tab-count:3'>                           </span><b
style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:KO'>Ngân
hàng TNHH MTV Shinhan Việt Nam</span></b><span style='mso-fareast-language:
KO'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;
layout-grid-mode:char;mso-layout-grid-align:none'><i style='mso-bidi-font-style:
normal'><span style='mso-fareast-language:KO'>On behalf of: <span
style='mso-tab-count:3'>                          </span>Shinhan Bank Vietnam
Ltd.,<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'>Đ</span>iện
thoại<span style='mso-fareast-language:KO'>/ <i style='mso-bidi-font-style:
normal'>Telephone: <span style='mso-tab-count:1'>           </span>08.3829 1581<o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Địa chỉ<span style='mso-fareast-language:KO'>/<i
style='mso-bidi-font-style:normal'>Address: <span style='mso-tab-count:2'>                     </span>138-142
Hai Bà Trưng, P.Dakao , Q.1, HCM<o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Và một bên là Ông/Bà:<span style='mso-fareast-language:
KO'><span style='mso-tab-count:1'>           </span><b style='mso-bidi-font-weight:
normal'><span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["full_name"].ToString() %></span><span
style='mso-tab-count:1'>          </span></b></span><span style='mso-tab-count:
1'>            </span><span style='mso-spacerun:yes'>                </span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;
layout-grid-mode:char;mso-layout-grid-align:none'><i style='mso-bidi-font-style:
normal'><span style='mso-fareast-language:KO'>And from other side, Mr./Ms.<span
style='mso-tab-count:4'>                                      </span> <o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Quốc tịch/<i style='mso-bidi-font-style:normal'>Nationality</i>:<span
style='mso-spacerun:yes'>  </span><span style='mso-tab-count:1'>           </span><span
style='color:red'><%=dt_total.Rows[i]["nation"].ToString() %></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Sinh ngày <span style='mso-fareast-language:KO'><span
style='mso-tab-count:1'>       </span><span style='mso-tab-count:2'>                        </span><span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["birth_dt"].ToString() %></span><span style='mso-tab-count:
5'>                                                        </span><span
style='mso-spacerun:yes'>     </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;layout-grid-mode:char;
mso-layout-grid-align:none'><i style='mso-bidi-font-style:normal'><span
style='mso-fareast-language:KO'>Date of Birth:<span style='mso-tab-count:7'>                                                                          </span><span
style='mso-spacerun:yes'>     </span><span style='mso-tab-count:1'>       </span><o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;
layout-grid-mode:char;mso-layout-grid-align:none'>Nghề nghiệp<span
style='mso-fareast-language:KO'>/<i style='mso-bidi-font-style:normal'>Occupation</i>:
<span style='mso-tab-count:1'>      </span>Nhân viên ngân hàng/ <i
style='mso-bidi-font-style:normal'>Banking Employee</i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Địa chỉ thường trú<span style='mso-fareast-language:
KO'>: <span style='mso-tab-count:2'>                </span><span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["permanent_addr"].ToString() %></span><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'>H<i
style='mso-bidi-font-style:normal'>ome Address: <o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;layout-grid-mode:char;
mso-layout-grid-align:none'>Số CMND<span style='mso-fareast-language:KO'>/<i
style='mso-bidi-font-style:normal'>ID/Passport No</i>.</span>:<span
style='mso-spacerun:yes'>   </span><span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["person_id"].ToString() %></span><span
style='mso-fareast-language:KO'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;mso-hyphenate:none;tab-stops:-.5in;
layout-grid-mode:char;mso-layout-grid-align:none'>Cấp ngày<span
style='mso-fareast-language:KO'>/ <i style='mso-bidi-font-style:normal'>Issued
on <span style='mso-tab-count:1'>   </span><span
style='mso-spacerun:yes'>  </span><span style='mso-tab-count:1'>          </span><span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["issue_dt"].ToString() %></span><span style='mso-tab-count:
2'>                    </span></i> <span style='mso-tab-count:2'>                       </span><i
style='mso-bidi-font-style:normal'><span style='mso-spacerun:yes'> </span></i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='mso-fareast-language:KO'>Tại/ <i style='mso-bidi-font-style:normal'>Issued
at:<span style='mso-spacerun:yes'>   </span><span style='mso-tab-count:2'>                       </span><span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["place_per_id"].ToString() %></span><o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='color:#333333'>Căn cứ Hợp đồng lao động số. /</span><i style='mso-bidi-font-style:
normal'><span style='mso-fareast-language:KO'> Base on Labor contract No: <span
style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["contract_no"].ToString() %></span></span></i><span
style='color:#333333'><span style='mso-tab-count:2'>                       </span>
<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='color:#333333'>Ký ngày /</span><i style='mso-bidi-font-style:normal'><span
style='mso-fareast-language:KO'> dated: <span style='mso-no-proof:yes'><%=dt_total.Rows[i]["begin_contract"].ToString() %></span><span
style='mso-tab-count:1'>    </span></span></i><span style='color:#333333'><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='color:#333333'>hai bên cùng nhau thỏa thuận </span><span
style='color:#333333;mso-fareast-language:KO'>sửa </span><span
style='color:#333333'>đổi một số nội dung của hợp đồng mà hai bên đã ký kết như
sau</span><span style='color:#333333;mso-fareast-language:KO'>:<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'> </span>two parties agree to amend the signed labor
contract<span style='mso-spacerun:yes'>  </span>as follows:<o:p></o:p></span></i></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:46.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:-.25in;line-height:12.0pt;mso-list:l0 level1 lfo1;
tab-stops:list 46.35pt;layout-grid-mode:char;mso-layout-grid-align:none'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-fareast-language:KO'><span
style='mso-list:Ignore'>1.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><b style='mso-bidi-font-weight:normal'><span
style='mso-fareast-language:KO'>Nội dung sửa đổi</span></b><span
style='mso-fareast-language:KO'>/<i style='mso-bidi-font-style:normal'>Content
of amendment</i>: <o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:.5in;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'>Điều 3.1 sửa
đổi về mức tiền lương, tiền công, phụ cấp <span
style='mso-spacerun:yes'> </span>như sau:<o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:.5in;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'> </span><i style='mso-bidi-font-style:normal'>Article
3.1 is amended about Basic salary or wage, and allowances as follows:</i> <o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:.5in;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><b style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:
KO'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><b style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:
KO'>Mức lương chính hoặc tiền công/</span> <i style='mso-bidi-font-style:normal'>Basic
salary or wage</i></b><b style='mso-bidi-font-weight:normal'><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO'>:</span></i></b><b
style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'>  </span><span style='color:red'><%=dt_total.Rows[i]["new_sal"].ToString() %><span
style='mso-spacerun:yes'>   </span></span>VNĐ tháng/<i style='mso-bidi-font-style:
normal'>month</i><o:p></o:p></span></b></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:.5in;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:10.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:.5in;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><span style='mso-fareast-language:KO'>Phụ cấp chức
vụ, phụ cấp công việc và các phụ cấp khác theo chính sách nội bộ của Ngân hàng/<i
style='mso-bidi-font-style:normal'> Job Title Allowance, job title allowance
and other are stipulated by the Bank internal rules.</i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:46.35pt;text-align:justify;text-justify:
inter-ideograph;text-indent:-.25in;line-height:12.0pt;mso-list:l0 level1 lfo1;
tab-stops:list 46.35pt;layout-grid-mode:char;mso-layout-grid-align:none'><![if !supportLists]><span
style='mso-fareast-font-family:"Times New Roman";mso-fareast-language:KO'><span
style='mso-list:Ignore'>2.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><b style='mso-bidi-font-weight:normal'><span
style='mso-fareast-language:KO'>Thời gian thực hiện</span></b><span
style='mso-fareast-language:KO'>/ <i style='mso-bidi-font-style:normal'>Effective
time</i>:<span style='mso-spacerun:yes'>  </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:46.35pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:46.35pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'>Phụ lục có hiệu lực từ: <span
style='mso-tab-count:1'>        </span><span style='color:red'><%=dt_total.Rows[i]["signature_date"].ToString() %></span><span
style='mso-tab-count:1'>          </span><b style='mso-bidi-font-weight:normal'><span
style='mso-tab-count:1'>            </span></b><span style='mso-tab-count:1'>            </span><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:40.0pt;text-align:justify;text-justify:
inter-ideograph;text-indent:6.35pt;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><i style='mso-bidi-font-style:normal'><span
style='mso-fareast-language:KO'>This Annex takes effect as from <o:p></o:p></span></i></p>

<p class=MsoNormal style='margin-left:40.0pt;text-align:justify;text-justify:
inter-ideograph;text-indent:6.35pt;line-height:12.0pt;layout-grid-mode:char;
mso-layout-grid-align:none'><i style='mso-bidi-font-style:normal'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></i></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'>-Người sử dụng lao động và người
lao động có nghĩa vụ tuân thủ các quy định của Luật lao động, Luật thuế thu nhập
cá nhân, Luật Bảo hiểm xã hội, Luật Bảo hiểm y tế, Luật Bảo hiểm thất nghiệp và
các quy định pháp luật khác mà không được đề cập trong Hợp đồng lao động và các
Phụ lục hợp đồng./ <i style='mso-bidi-font-style:normal'>The Employer and
Employee are obligated to comply with the regulations governed by prevailing
Labor code, Personal Income Tax Law, Social Insurance Law, Health Insurance
Law, Unemployment Insurance Law and other legal documents which are not
mentioned in the Labor contract and Annexes of Labor contract.<o:p></o:p></i></span></p>

<p class=MsoNormal style='margin-bottom:6.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'>-Người lao động có nghĩa vụ kịp thời
thông báo cho Phòng Nhân sự của Ngân hàng<span style='mso-spacerun:yes'> 
</span>những thay đổi về cá nhân như nhân thân, địa chỉ thường trú/ tạm trú dài
hạn, trình độ học vấn, sức khỏe và các thông tin cá nhân có liên quan khác được
đề cập trong Hợp đồng lao động và các phụ lục Hợp đồng lao động./ <i
style='mso-bidi-font-style:normal'>The employee is obligated to inform in due
course to the HR Dept. of Bank of any changes with regards to personal records
and status such as permanent/registered address, health status, education
status and other relevant personal data which are written on the Labor contract
and all Annexes to the Labor</i> contract.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='mso-fareast-language:KO'>Phụ lục này là bộ phận không thể tách rời của Hợp
đồng lao động số/ <i style='mso-bidi-font-style:normal'>This Appendix is an integral
part of the labor contract No. <span style='color:red;mso-no-proof:yes'><%=dt_total.Rows[i]["contract_no"].ToString() %></span></i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><span
style='mso-fareast-language:KO'>được làm thành hai bản có giá trị như nhau, mỗi
bên giữ một bản và là cơ sở để giải quyết khi có tranh chấp lao động.<o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:none'><i
style='mso-bidi-font-style:normal'><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'> </span>which is made in 02 copies of equal validity,
each party keeps one copy and used as basis for settlement of labor dispute.</span></i><span
style='mso-fareast-language:KO'><o:p></o:p></span></p>

<p class=MsoNormal style='margin-left:40.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:40.0pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='margin-left:28.35pt;text-align:justify;text-justify:
inter-ideograph;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'>Người lao động/ <i
style='mso-bidi-font-style:normal'>Employee</i><span style='mso-tab-count:4'>                                            </span>Người
sử dụng lao động/ <i style='mso-bidi-font-style:normal'>Employer<o:p></o:p></i></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph;
text-indent:28.35pt;line-height:12.0pt;layout-grid-mode:char;mso-layout-grid-align:
none'><span style='mso-fareast-language:KO'><span
style='mso-spacerun:yes'>      </span>(Ký tên) <i style='mso-bidi-font-style:
normal'>Signature</i><span style='mso-tab-count:5'>                                                   </span>(Ký
tên, đóng dấu) <i style='mso-bidi-font-style:normal'>Signature and Stamp</i><o:p></o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><o:p>&nbsp;</o:p></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
style='mso-fareast-language:KO'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><b
style='mso-bidi-font-weight:normal'><span style='mso-fareast-language:KO'><span
style='mso-tab-count:4'>                                                </span></span></b><b
style='mso-bidi-font-weight:normal'><span lang=NL style='mso-ansi-language:
NL;mso-fareast-language:KO'><span style='mso-tab-count:5'>                                                            </span><span
style='mso-spacerun:yes'>    </span>LEE WON SUK<o:p></o:p></span></b></p>

<p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
lang=NL style='mso-ansi-language:NL;mso-fareast-language:KO'><span
style='mso-tab-count:8'>                                                                                                </span><span
style='mso-spacerun:yes'> </span>Giám đốc Hành Chính- Nhân Sự<o:p></o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><span lang=NL
style='mso-ansi-language:NL;mso-fareast-language:KO'><span
style='mso-spacerun:yes'>                                                                                
</span><i style='mso-bidi-font-style:normal'>HR- GA Director<o:p></o:p></i></span></p>

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
