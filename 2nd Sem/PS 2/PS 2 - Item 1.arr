fun poly(n :: Number, k :: Number) -> Number:
  if (k == 1):
    1
  else:
    (k * num-expt(n, k - 1)) + poly(n, k - 1)
  end
end
