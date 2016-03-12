note
	description: "[

		]"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current
		local
			l_env: EXECUTION_ENVIRONMENT
			l_file: PLAIN_TEXT_FILE
			l_dir: DIRECTORY
			l_path: PATH
			l_content,
			l_class,
			l_name: STRING
			l_rand: RANDOMIZER
		do
			if argument_count = 1 and then attached {STRING} argument (1) as al_project_name then
				-- Build ECF
				create l_rand
				create l_env
				if attached l_env.starting_environment.item ("GITHUB") as al_github then
					print ("Create new in: " + al_github.out + "%N")
					l_content := ecf_template_string.twin
					l_content.replace_substring_all ("<<ECF_NAME>>", al_project_name)
					l_content.replace_substring_all ("<<UUID>>", l_rand.uuid.out)

						-- Root folder ...
					create l_path.make_from_string (al_github + "\" + al_project_name)
					create l_dir.make_with_path (l_path)
					if not l_dir.exists then
						l_dir.create_dir
					end

						-- ECF file ...
					create l_file.make_create_read_write (l_path.absolute_path.name + "\" + al_project_name + ".ecf")
					l_file.put_string (l_content)
					l_file.close

						-- Test folder ...
					create l_path.make_from_string (al_github + "\" + al_project_name + "\tests")
					create l_dir.make_with_path (l_path)
					if not l_dir.exists then
						l_dir.create_dir
					end

						-- Test class ...
					l_class := al_project_name.twin
					l_name := al_project_name.twin
					l_name.to_upper
					l_class.to_upper
					l_class.append ("_TEST_SET.e")
					l_content := abc_test_class.twin
					l_content.replace_substring_all ("<<TEST_CLASS_NAME>>", l_name)
					create l_file.make_create_read_write (l_path.absolute_path.name + "\" + l_class)
					l_file.put_string (l_content)
					l_file.close

						-- Finished ...
					print ("Created new ECF in " + l_path.absolute_path.name)
				else
					print ("Missing GITHUB environment variable. Please define before running.%N")
					print ("Run: C:\Windows\ImmersiveControlPanel\SystemSettings.exe%N")
				end
			else
				print ("Missing new ECF name.%N")
			end
		end

feature {NONE} -- Implementation

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

	abc_test_class: STRING = "[
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
