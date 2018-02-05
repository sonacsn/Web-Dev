defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  """

  @doc """
  Calculator

  ## Examples

      iex> Calc.eval("30 + 20")
      50

      iex> Calc.eval("(20 * 15 ) / 30 + 20")
      30

  """
  def main() do
    case IO.gets("input: ") do
      :eof ->
        IO.puts "All done"
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      line ->
        IO.puts(eval(line))
        main()
    end
  end

  def eval(expr) do
    list = Regex.replace(~r[\s], expr, "")
    |> String.trim
    |> String.codepoints

    postfix_state = %{p: [], ops: [], input: list}
    |> get_postfix([])

    %{ pexp: postfix_state.p, stack: []}
    |> evaluate_postfix
  end

  def evaluate_postfix(state) do
    if state[:pexp] !== [] do
      [head | tail] = state.pexp
      if is_integer(head) do
        evaluate_postfix(%{state | pexp: tail, stack: state.stack ++ [head]})
      else
        {num2, rest} = pop(state.stack)
        {num1, rest} = pop(rest)
        result = operation(num1, head, num2)
        evaluate_postfix(%{state | pexp: tail, stack: rest ++ [result]})
      end
    else
      List.last(state.stack)
    end
  end

def get_postfix(state, digits) do
    cond do
      # Condition 1: Input string empty
      state[:input] !== [] ->
        [head | tail] = state[:input]
        state = %{state | input: tail}

        if is_digit?(head) do
          digits_list = digits ++ [head]
          get_postfix(state, digits_list)
        else

          if digits !== [] do
            #create number
            num = get_number(digits)
             state = %{state | p: state.p ++ [num]}
          end

          cond do 
            # Condition a:
            head == "(" ->
              # push left parenthesis to ops
              %{state | ops:  state.ops ++ [head]}

            # Condition b:
            head == ")" ->
              right_parenthesis(state)

            # Condition c: for other operators
            true ->
              other_operators(state, head)
          end
          |> get_postfix([])

        end

      # Condition 2
      digits !== [] ->
        #Add number in the buffet to P stack
        num = get_number(digits)
        get_postfix(%{state | p: state.p ++ [num]}, [])

      # Condition 3: when input is empty
      true ->
        get_state(state)
    end
  end


  defp right_parenthesis(state) do
    if state[:ops]!== [] && List.last(state[:ops]) !== "(" do
      {op, stack} = pop(state.ops)
      right_parenthesis(%{state | ops: stack, p: state.p ++ [op]})
    else
      {op, stack} = pop(state.ops)
      %{state | ops: stack}
    end
  end

  defp other_operators(state, op) do
    if state[:ops]==[] || List.last(state[:ops]) == "(" do
      %{state | ops: state.ops ++ [op]}
    else
      state = check_precedence(state, op)
      %{ state | ops: state.ops ++ [op]}
    end
  end

  defp check_precedence(state, op) do
    if state[:ops]!== [] && List.last(state[:ops])!=="("
    && get_precedence(op) <= get_precedence(List.last(state[:ops])) do
      {prev_op, stack} = pop(state[:ops])
      check_precedence(%{state | ops: stack, p: state.p ++ [prev_op]}, op )
    else
      state
    end
  end

  defp get_state(state) do
    if state[:ops]!== [] && state[:input] == [] do
      {op, stack} = pop(state[:ops])
      get_state(%{state | ops: stack, p: state.p ++ [op]})
    else
      state
    end
  end

########################## HELPER FUNCTIONS #######################

  def is_digit?(x) do
    Regex.match?(~r[\d], x)
  end

  def get_number(digits) do
    Enum.reduce(digits, 0, fn(x, acc) ->
      acc * 10 + String.to_integer(x) end)
  end

  def pop(list) do
    List.pop_at(list, length(list)-1)
  end

  def operation(num1, op, num2) do
    case op do
      "+" -> num1 + num2
      "-" -> num1 - num2
      "*" -> num1 * num2
      "/" -> div(num1, num2)
    end
  end

  def get_precedence(x) do
    case x do
      "+" -> 1
      "-" -> 1
      "*" -> 2
      "/" -> 2
      "(" -> 3
      ")" -> 3
    end
  end
end
