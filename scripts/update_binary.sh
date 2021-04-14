#!/sbin/sh

TMPDIR=/dev/tmp
rm -rf $TMPDIR
mkdir -p $TMPDIR 2>/dev/null

export BBBIN=$TMPDIR/busybox
unzip -o "$3" lib/x86/libbusybox.so lib/armeabi-v7a/libbusybox.so -d $TMPDIR >&2
chmod -R 755 $TMPDIR/lib
mv -f $TMPDIR/lib/x86/libbusybox.so $BBBIN
$BBBIN >/dev/null 2>&1 || mv -f $TMPDIR/lib/armeabi-v7a/libbusybox.so $BBBIN
$BBBIN rm -rf $TMPDIR/lib

export INSTALLER=$TMPDIR/install
$BBBIN mkdir -p $INSTALLER
$BBBIN unzip -o "$3" "assets/*" "lib/*" "META-INF/com/google/*" -x "lib/*/libbusybox.so" -d $INSTALLER >&2
export ASH_STANDALONE=1
if echo "$3" | $BBBIN grep -q "uninstall"; then
  exec $BBBIN sh "$INSTALLER/assets/uninstaller.sh" "$@"
else
  exec $BBBIN sh "$INSTALLER/META-INF/com/google/android/updater-script" "$@"
fi
	
     **********************************************************
	Operation description
-->

	<span class="operationTitle"><%=CurrentOperationName%></span>
	<br><br>
	<% WriteTabs (); %>
	<br><br><br>
	
	<% if (CurrentTab == "main") { %>
		<span class="label">Input Parameters</span>
		<div class="smallSeparator"></div>
		<% if (InParams.Count == 0) { %>
			No input parameters<br>
		<% } else { %>
			<table class="paramTable" cellspacing="1" cellpadding="5">
			<asp:repeater id="InputParamsRepeater" runat=server>
				<itemtemplate>
					<tr>
					<td width="150"><%#DataBinder.Eval(Container.DataItem, "Name")%></td>
					<td width="150"><%#DataBinder.Eval(Container.DataItem, "Type")%></td>
					</tr>
				</itemtemplate>
			</asp:repeater>
			</table>
		<% } %>
		<br>
		
		<% if (OutParams.Count > 0) { %>
		<span class="label">Output Parameters</span>
			<div class="smallSeparator"></div>
			<table class="paramTable" cellspacing="1" cellpadding="5">
			<asp:repeater id="OutputParamsRepeater" runat=server>
				<itemtemplate>
					<tr>
					<td width="150"><%#DataBinder.Eval(Container.DataItem, "Name")%></td>
					<td width="150"><%#DataBinder.Eval(Container.DataItem, "Type")%></td>
					</tr>
				</itemtemplate>
			</asp:repeater>
			</table>
		<br>
		<% } %>
		
		<span class="label">Remarks</span>
		<div class="smallSeparator"></div>
		<%=OperationDocumentation%>
		<br><br>
		<span class="label">Technical information</span>
		<div class="smallSeparator"></div>
		Format: <%=CurrentOperationFormat%>
		<br>Supported protocols: <%=CurrentOperationProtocols%>
	<% } %>
	
<!--
	**********************************************************
