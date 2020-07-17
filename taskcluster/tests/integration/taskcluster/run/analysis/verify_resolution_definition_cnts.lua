-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "string"
require "table"

local ecnts = {task_definition = 14, pulse_task = 14}
local acnts = {}

function process_message()
    local t = read_message("Type")
    local cnt = acnts[t]
    if not cnt then
        acnts[t] = 1
    else
        acnts[t] = cnt + 1
    end
    return 0
end

function timer_event(ns)
    for k,ecnt in pairs(ecnts) do
        local acnt = acnts[k]
        if ecnt ~= acnt then error(string.format("%s messages received %d expected: %d", k, acnt,  ecnt)) end
    end
end
