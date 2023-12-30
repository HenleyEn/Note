<map version="freeplane 1.11.5">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="mqtt" LOCALIZED_STYLE_REF="AutomaticLayout.level.root" FOLDED="false" ID="ID_1090958577" CREATED="1409300609620" MODIFIED="1701967860642"><hook NAME="MapStyle" background="#000000" zoom="1.3301998">
    <properties show_icon_for_attributes="true" edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" show_note_icons="true" associatedTemplateLocation="template:/dark_nord_template.mm" fit_to_viewport="false"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ID="ID_671184412" ICON_SIZE="12 pt" FORMAT_AS_HYPERLINK="false" COLOR="#484747" BACKGROUND_COLOR="#eceff4" STYLE="bubble" SHAPE_HORIZONTAL_MARGIN="8 pt" SHAPE_VERTICAL_MARGIN="5 pt" BORDER_WIDTH_LIKE_EDGE="false" BORDER_WIDTH="1.9 px" BORDER_COLOR_LIKE_EDGE="true" BORDER_COLOR="#f0f0f0" BORDER_DASH_LIKE_EDGE="true" BORDER_DASH="SOLID">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#88c0d0" WIDTH="2" TRANSPARENCY="255" DASH="" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_671184412" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<font NAME="SansSerif" SIZE="11" BOLD="false" STRIKETHROUGH="false" ITALIC="false"/>
<edge STYLE="bezier" COLOR="#81a1c1" WIDTH="3" DASH="SOLID"/>
<richcontent TYPE="DETAILS" CONTENT-TYPE="plain/auto"/>
<richcontent TYPE="NOTE" CONTENT-TYPE="plain/auto"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details" BORDER_WIDTH="1.9 px">
<edge STYLE="bezier" COLOR="#81a1c1" WIDTH="3"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ebcb8b">
<icon BUILTIN="clock2"/>
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.floating" COLOR="#484747">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.selection" COLOR="#e5e9f0" BACKGROUND_COLOR="#5e81ac" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#5e81ac"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.important" ID="ID_779275544" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#bf616a">
<icon BUILTIN="yes"/>
<arrowlink COLOR="#bf616a" TRANSPARENCY="255" DESTINATION="ID_779275544"/>
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.flower" COLOR="#ffffff" BACKGROUND_COLOR="#255aba" STYLE="oval" TEXT_ALIGN="CENTER" BORDER_WIDTH_LIKE_EDGE="false" BORDER_WIDTH="22 pt" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#f9d71c" BORDER_DASH_LIKE_EDGE="false" BORDER_DASH="CLOSE_DOTS" MAX_WIDTH="6 cm" MIN_WIDTH="3 cm"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#ffffff" BACKGROUND_COLOR="#484747" STYLE="bubble" SHAPE_HORIZONTAL_MARGIN="10 pt" SHAPE_VERTICAL_MARGIN="10 pt">
<font NAME="Ubuntu" SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#eceff4" BACKGROUND_COLOR="#d08770" STYLE="bubble" SHAPE_HORIZONTAL_MARGIN="8 pt" SHAPE_VERTICAL_MARGIN="5 pt">
<font NAME="Ubuntu" SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#3b4252" BACKGROUND_COLOR="#ebcb8b">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#2e3440" BACKGROUND_COLOR="#a3be8c">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#2e3440" BACKGROUND_COLOR="#b48ead">
<font SIZE="11"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5" BACKGROUND_COLOR="#81a1c1">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6" BACKGROUND_COLOR="#88c0d0">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7" BACKGROUND_COLOR="#8fbcbb">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8" BACKGROUND_COLOR="#d8dee9">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9" BACKGROUND_COLOR="#e5e9f0">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10" BACKGROUND_COLOR="#eceff4">
<font SIZE="9"/>
</stylenode>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="accessories/plugins/AutomaticLayout.properties" VALUE="ALL"/>
<font BOLD="true"/>
<node TEXT="uart1" POSITION="bottom_or_right" ID="ID_1172673226" CREATED="1701967864356" MODIFIED="1701967870730">
<node TEXT="log_task" ID="ID_519800325" CREATED="1701967872300" MODIFIED="1701967894291"/>
</node>
<node TEXT="uart3_dma" POSITION="top_or_left" ID="ID_1223379674" CREATED="1701967874589" MODIFIED="1701967885226">
<node TEXT="dma_rx" ID="ID_471434781" CREATED="1702220039292" MODIFIED="1702220045870"/>
<node TEXT="dma_tx" ID="ID_1624399696" CREATED="1702220046845" MODIFIED="1702220050396"/>
<node TEXT="transfor dma data func" ID="ID_200384947" CREATED="1702220084601" MODIFIED="1702220298372"/>
</node>
<node TEXT="at_client" FOLDED="true" POSITION="bottom_or_right" ID="ID_199933907" CREATED="1701967898703" MODIFIED="1702276544010">
<node TEXT="at_create_resp" ID="ID_1555728096" CREATED="1702276028069" MODIFIED="1702276035371"/>
<node TEXT="at_delete_resp" ID="ID_77828125" CREATED="1702276036591" MODIFIED="1702276042474"/>
<node TEXT="at_resp_parse_line_args" ID="ID_654493539" CREATED="1702276051049" MODIFIED="1702276056542">
<node TEXT="at_resp_get_line" ID="ID_1770851887" CREATED="1702276043240" MODIFIED="1702276050267"/>
</node>
<node TEXT="at_obj_set_urc_table" ID="ID_1277622443" CREATED="1702276057261" MODIFIED="1702276062771"/>
<node TEXT="get_urc_obj" LOCALIZED_STYLE_REF="AutomaticLayout.level,2" ID="ID_7326565" CREATED="1702276064120" MODIFIED="1702277696939"/>
<node TEXT="at_recv_readline" ID="ID_82472829" CREATED="1702276101766" MODIFIED="1702276107419">
<node TEXT="at_client_getchar" ID="ID_149939095" CREATED="1702276075256" MODIFIED="1702276100860">
<node TEXT="device_read_buf" ID="ID_1794575692" CREATED="1702276802718" MODIFIED="1702276802718"/>
</node>
</node>
<node TEXT="at_client_init" ID="ID_92750944" CREATED="1702276108966" MODIFIED="1702276128332">
<node TEXT="at_client_para_init" ID="ID_1689672385" CREATED="1702276131379" MODIFIED="1702276142721"/>
</node>
<node TEXT="at_send_obj_cmd" ID="ID_858728209" CREATED="1702276246728" MODIFIED="1702276248728"/>
</node>
<node TEXT="client_data_task" POSITION="top_or_left" ID="ID_569806925" CREATED="1701967908095" MODIFIED="1701967931010"/>
<node TEXT="test_task" POSITION="bottom_or_right" ID="ID_1980350091" CREATED="1701967933084" MODIFIED="1701967941497">
<node TEXT="at_test" ID="ID_751678029" CREATED="1702276270874" MODIFIED="1702276272046"/>
</node>
<node TEXT="cmd_parser" POSITION="top_or_left" ID="ID_68503372" CREATED="1702276641764" MODIFIED="1702276652015"/>
</node>
</map>
