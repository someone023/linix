{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            # overloads the capslock key to function as both escape (when tapped) and control (when held)
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
