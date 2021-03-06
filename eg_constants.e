note
	description: "[
		Representation of {EG_CONSTANTS}
		]"

class
	EG_CONSTANTS

feature -- Constants

	ecf_template_string: STRING = "[
<?xml version="1.0" encoding="ISO-8859-1"?>
<system xmlns="http://www.eiffel.com/developers/xml/configuration-1-15-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-15-0 http://www.eiffel.com/developers/xml/configuration-1-15-0.xsd" name="<<ECF_NAME>>" uuid="<<UUID>>" readonly="false">
	<description><<ECF_NAME>> implementation</description>
	<target name="<<ECF_NAME>>">
		<root all_classes="true"/>
		<option warning="true" void_safety="transitional" syntax="provisional">
			<assertions precondition="true" postcondition="true" check="true" invariant="true" loop="true" supplier_precondition="true"/>
		</option>
		<setting name="console_application" value="true"/>
		<setting name="concurrency" value="scoop"/>
		<library name="base" location="$ISE_LIBRARY\library\base\base-safe.ecf"/>
		<library name="process" location="$ISE_LIBRARY\library\process\process-safe.ecf"/>
		<library name="pub_sub" location="$GITHUB\pub_sub\pub_sub.ecf"/>
		<library name="randomizer" location="$GITHUB\randomizer\randomizer.ecf"/>
		<library name="state_machine" location="$GITHUB\state_machine\state_machine.ecf"/>
		<library name="thread" location="$ISE_LIBRARY\library\thread\thread-safe.ecf"/>
		<library name="uuid" location="$ISE_LIBRARY\library\uuid\uuid-safe.ecf"/>
		<cluster name="<<ECF_NAME>>" location=".\" recursive="true">
			<file_rule>
				<exclude>/.git$</exclude>
				<exclude>/.svn$</exclude>
				<exclude>/CVS$</exclude>
				<exclude>/EIFGENs$</exclude>
				<exclude>tests</exclude>
			</file_rule>
		</cluster>
	</target>
	<target name="test" extends="<<ECF_NAME>>">
		<description>Pub sub test</description>
		<root class="ANY" feature="default_create"/>
		<file_rule>
			<exclude>/.git$</exclude>
			<exclude>/.svn$</exclude>
			<exclude>/CVS$</exclude>
			<exclude>/EIFGENs$</exclude>
			<include>tests</include>
		</file_rule>
		<option profile="false">
		</option>
		<setting name="console_application" value="false"/>
		<library name="testing" location="$ISE_LIBRARY\library\testing\testing-safe.ecf"/>
		<library name="vision2" location="$ISE_LIBRARY\library\vision2\vision2-safe.ecf"/>
		<cluster name="tests" location=".\tests\" recursive="true"/>
	</target>
</system>

]"

	test_class_template_string: STRING = "[
note
	description: "Tests of {<<TEST_CLASS_NAME>>}."
	testing: "type/manual"

class
	<<TEST_CLASS_NAME>>_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

feature -- Test routines

	abc_tests
			-- `abc_tests'
		do
			do_nothing -- yet ...
		end

end

]"

end
