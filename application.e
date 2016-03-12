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
			l_class_file_name,
			l_class_text_class_name: STRING
			l_randomizer: RANDOMIZER
			l_process: PROCESS_IMP
		do
			if argument_count = 1 and then attached {STRING} argument (1) as al_project_name then
				-- Build ECF
				create l_randomizer
				create l_env
				if attached l_env.starting_environment.item ("GITHUB") as al_github then
					print ("Create new in: " + al_github.out + "%N")
					l_content := {EG_CONSTANTS}.ecf_template_string
					l_content.replace_substring_all ("<<ECF_NAME>>", al_project_name)
					l_content.replace_substring_all ("<<UUID>>", l_randomizer.uuid.out)

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
					l_class_text_class_name := al_project_name.twin
					l_class_text_class_name.to_upper

					l_class_file_name := al_project_name.twin
					l_class_file_name.to_upper
					l_class_file_name.append ("_test_set.e")

					l_content := {EG_CONSTANTS}.test_class_template_string
					l_content.replace_substring_all ("<<TEST_CLASS_NAME>>", l_class_text_class_name)
					create l_file.make_create_read_write (l_path.absolute_path.name + "\" + l_class_file_name)
					l_file.put_string (l_content)
					l_file.close

						-- Finished ...
					print ("Created new ECF in " + l_path.absolute_path.name)
				else
					print ("Missing GITHUB environment variable. Please define before running.%N")
					print ("For Example: In Windows 10, run: C:\Windows\ImmersiveControlPanel\SystemSettings.exe%N")
				end
			else
				print ("Missing new ECF name or too many arguments.%N")
			end
		end

end
