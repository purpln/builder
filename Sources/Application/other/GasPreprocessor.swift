struct GasPreprocessor {
    init() throws {
        if !bool(command: "gas-preprocessor.pl") {
            print("'gas-preprocessor.pl' not found")
            print("installing 'gas-preprocessor.pl'...")
            
            let command = """
                curl -L https://github.com/libav/gas-preprocessor/raw/master/gas-preprocessor.pl \
                -o /usr/local/bin/gas-preprocessor.pl \
                && chmod +x /usr/local/bin/gas-preprocessor.pl
            """
            try launch(command: command)
        }
    }
}
