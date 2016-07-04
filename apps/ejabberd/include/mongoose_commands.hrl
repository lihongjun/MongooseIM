
-type command_action() :: [get|send|set|delete].

-type typedef() :: integer|binary|float. %% most basic primitives, string is a binary

-type argspec() :: typedef()
                  |{atom(), typedef()} %% a named argument
                  |{argspec()} % a tuple of a few args (can be of any size)
                  |[typedef()]. % a list, but one element

-type security() :: [admin|whatnot]. %% to be determined

-type errortype() :: denied|not_implemented|type_error|internal. %% we should agree on a set of atoms so that the frontend can map it to http codes

-type success() :: {ok, argspec()}.

-type failure() :: {error, errortype(), binary()}.

-record(mongoose_command, {
    name :: atom(),                             %% name of the command by which we refer to it
    tags = [] :: [atom()],                      %% an arbitrary number of arbitrary tags
    desc :: string(),                           %% long description
    module :: module(),                         %% module to call
    function :: atom(),                         %% function to call
    action :: command_action(),                 %% so that the HTTP side can decide which verb to require
    args = [] :: [argspec()],                %% this is both for introspection and type check on call
    security_policy = [admin] :: security(),    %% permissions required to run this command
    result :: success()
}).

