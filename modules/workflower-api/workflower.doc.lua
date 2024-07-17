---@diagnostic disable: assign-type-mismatch, inject-field
---@meta

--- @version 5.1
--- Workflower 0.1.0 module documentation.
--- The workflower library provides a structured way to define and execute a series of computational steps, or "cells," which can branch conditionally 
--- based on the outputs of these cells. This is useful for workflows, pipelines, state machines, or any process where the flow of execution can change dynamically.
---@module 'workflower'

--- WorkflowerOptions options structure
---@class WorkflowerOptions
---@field [1] string The entry point - name of the cell
---@field [2] table The graph structure - a list of the cells in order, 
--- with branches being sublists such as {'b', 'c'} in {'a', {'b', 'c'}, 'd'}
local workflowerOptions = {}

--- Workflower class.
---@class Workflower
--- A directed graph of computational cells, allowing conditional branching based on the return values of cell functions.
---@field private _cells table The cells in the workflower.
---@field private _entry string The entry point of the workflower.
---@field private _graph table The directed graph structure of the workflower.
---@field private _events table The events in the workflower.
local workflower = {}

--- Creates a new workflower instance.
---@param options WorkflowerOptions The options table containing entry point and graph structure.
---@param ... table Any parent workflower instances to inherit from.
---@return Workflower The new workflower instance.
function workflower.new(options, ...) end

--- Adds a new cell to the workflower instance.
---@param flower Workflower The workflower instance.
---@param id string The identifier for the cell.
---@param fn function The function to execute for this cell.
---@return table The created cell.
function workflower.cell(flower, id, fn) end

--- Retrieves a cell from the workflower instance.
---@param flower Workflower The workflower instance.
---@param cell_id string The identifier of the cell to retrieve.
---@return table The requested cell.
function workflower.get_cell(flower, cell_id) end

--- Executes the workflower instance as a function.
---@param self Workflower The workflower instance.
---@param ... any Additional arguments to pass to the entry cell function.
---@return any The final results of the execution.
function workflower.__call(self, ...) end

--- Executes a cell and its subsequent cells based on the graph.
---@param cell table The cell to start execution from.
---@param call_index number The current index in the execution sequence.
---@param ... any Additional arguments to pass to the cell function.
---@return any The final results of the execution.
function workflower.execute(cell, call_index, ...) end

--- Bucket class.
---@class Bucket
---@field contents any Contains the current bucket contents, can be retrieved with @Bucket:get().
local Bucket = {}

--- Creates a new Bucket instance.
--- A Bucket is a simple state wrapper with an associated cell function that 
--- can be called in a Workflower chain to push the current input/output into a 
--- bucket on the side without disrupting the flow.
---@param _next string The next cell identifier.
---@return Bucket, function The new Bucket instance and its corresponding cell function.
function Bucket.new(_next) end

--- Gets the contents of the Bucket
---@param self Bucket
---@return any The contents of the Bucket.
function Bucket.get(self) end

--- Sets the contents of the Bucket.
---@param self Bucket
---@param ... any The contents to set in the Bucket.
function Bucket.set(self, ...) end

--- Creates a new Bucket instance.
--- A Bucket is a simple state wrapper with an associated cell function that 
--- can be called in a Workflower chain to push the current input/output into a 
--- bucket on the side without disrupting the flow.
---@param _next string The next cell identifier.
---@return Bucket, function The new Bucket instance and its corresponding cell function.
function workflower.bucket(_next) end

--- Pipe class.
---@class Pipe
local pipe = {}

--- Creates a new pipe instance.
---@param _next string The next cell identifier.
---@param fn function The function to execute for this pipe.
---@return function The new pipe cell function.
function pipe.new(_next, fn) end

--- Creates a new pipe instance.
---@param _next string The next cell identifier.
---@param fn function The function to execute for this pipe.
---@return function The new pipe function.
function workflower.pipe(_next, fn) end

--- Debugger class.
---@class Debugger
local debugger = {}

--- Logs an error and formats the traceback.
---@param id string The identifier of the cell where the error occurred.
---@param flower Workflower The workflower instance.
---@param traceback string The traceback string.
function debugger.error(id, flower, traceback) end

--- Creates a debug cell container.
---@param fn function The function to be debugged.
---@return table The debug cell container.
function debugger.debug_cell_container(fn) end

--- Transforms a cell function into a debug cell.
---@param debug_object table The debug object containing the function to debug.
---@param cell_id string The identifier of the cell.
---@param flower Workflower The workflower instance.
---@return function The transformed debug cell function.
function debugger.debug_cell(debug_object, cell_id, flower) end

--- Wraps a Workflower cell into a debugger that outputs an accurate trace on error.
---@param cell function The cell function being wrapped
---@return table The debugger cell container wrapping 'cell'
function workflower.debug(cell) end


return ---@type fun(options: WorkflowerOptions, ...: any): Workflower
{
    --- Creates a new Workflower instance.
    new = workflower.new,
    --- Creates a new Bucket instance for storing the output at any point in the workflow.
    bucket = workflower.bucket,
    --- Creates a new cell instance that pipes output into a function outside of the workflow.
    pipe = workflower.pipe,
    --- Wraps a Workflower cell into a debugger that outputs an accurate trace on error.
    debug = workflower.debug,
}