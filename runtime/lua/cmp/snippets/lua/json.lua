---@diagnostic disable: undefined-global
return {
	s({ trig = "pydapconf", dscr = "Python dap configuration" }, {
		c(1, {
			sn(nil, {
				i(1),
				t({ "{", [[  "configurations": []], "    " }),
				i(2, "conf"),
				t({ [[]], "  ]", "}" }),
			}),
			sn(nil, {
				i(1),
				t({ "{", [[  "configurations": []], "    " }),
				i(2, "conf"),
				t({ [[]], "  ],", [[  "inputs": []], "    " }),
				i(3, "input_node"),
				t({ [[]], "  ]", "}" }),
			}),
		}),
	}),
	s({ trig = "dapconf", dscr = "dap configuration node" }, {
		t({ "{", [[  "name": "]] }),
		i(1, "name"),
		t({ [[",]], [[  "type": "]] }),
		i(2, "type"),
		t({ [[",]], [[  "request": "]] }),
		-- OPTIM: use choice node "attach", "launch"
		i(3, "request"),
		t({ [[",]], [[  "program": "]] }),
		i(4, "${file}"),
		t({ [[",]], [[  "console": "]] }),
		c(5, { t("integratedTerminal"), t("externalTerminal"), t("internalConsole") }),
		t({ [[",]], [[  "justMycode": ]] }),
		c(6, { t("true"), t("false") }),
		t({ [[]], [[}]] }),
	}),
	s({ trig = "inputconf", dscr = "dap input node" }, {
		t({ "{", [[  "id": "]] }),
		i(1, "ID"),
		t({ [[",]], [[  "type": "]] }),
		c(2, { t("promptString"), t("pickString") }),
		t({ [[",]], [[  "description": "]] }),
		i(3, "description"),
		t({ [[",]], [[  "default": "]] }),
		i(4, "default"),
		d(5, function(args)
			print(vim.inspect(args))
			if args[1][1] == "pickString" then
				return sn(nil, {
					t({ [[",]], [[  "options": ]] }),
					i(1, "options:Array"),
					t({ [[]], [[}]] }),
				})
			else
				return sn(nil, {
					t({ [["]], [[}]] }),
				})
			end
		end, { 2 }),
		i(0),
	}),
}
