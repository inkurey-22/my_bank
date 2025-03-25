       identification division.
       program-id. my_bank.

       data division.
       working-storage section.

      *> Account structure
       01 accounts.
           05 account-table occurs 100 times.
               10 acc-id pic 9(5).
               10 acc-password pic x(20).
               10 acc-bal pic 9(9)v99.

      *> Account index
       01 acc-index pic 9(5) value 1.

      *> User inputs variables (COBOL doesn't have local variables)
       01 action pic 9(1).
       01 passwd-buffer1 pic x(20).
       01 passwd-buffer2 pic x(20).
       01 amount pic 9(5)v99.
       01 src-acc pic 9(5).
       01 dest-acc pic 9(5).

       procedure division.
           perform main.
           goback.

       *> Main procedure to handle user actions
       main.
           perform until action = 5
               display "Select an action: " end-display
               display "1. Initialize Account" end-display
               display "2. Display Account" end-display
               display "3. Add money to account" end-display
               display "4. Transfer money between accounts" end-display
               display "5. Exit" end-display
               display "-> " with no advancing end-display
               accept action end-accept
               display " " end-display
               evaluate action
                   when "1"
                       perform init-acc
                   when "2"
                       perform display-acc
                   when "3"
                       perform add-money
                   when "4"
                       perform transfer-money
                   when "5"
                       perform end-prog
                   when other
                       display "Invalid action" end-display
                       display " " end-display
               end-evaluate
           end-perform.

       *> Procedure to initialize a new account
       init-acc.
           if acc-index > 100
               display "Maximum number of accounts reached" end-display
               display " " end-display
               exit paragraph
           end-if
           move acc-index to acc-id (acc-index)
           move 0 to acc-bal (acc-index)
           display "Create password: " with no advancing end-display.
           accept passwd-buffer1 end-accept.
           display "Confirm password: " with no advancing end-display.
           accept passwd-buffer2 end-accept.
           if passwd-buffer1 not = passwd-buffer2
               display "Passwords do not match" end-display
               display " " end-display
               exit paragraph
           end-if
           move passwd-buffer1 to acc-password (acc-index)
           move spaces to passwd-buffer1
           move spaces to passwd-buffer2
           display "Account created with ID: " acc-index end-display.
           display " " end-display.
           add 1 to acc-index end-add.

       *> Procedure to display account details
       display-acc.
           display "Choose an account : " with no advancing end-display.
           accept dest-acc end-accept.
           display "Account Password: " with no advancing end-display.
           accept passwd-buffer1 end-accept.
           if passwd-buffer1 not = acc-password (dest-acc)
               display "Invalid password" end-display
               display " " end-display
               exit paragraph
           end-if
           display "Account ID: " acc-id (dest-acc) end-display.
           display "Account Balance: " acc-bal (dest-acc) end-display.
           display " " end-display.
       *> Procedure to add money to an account
       add-money.
           display "Choose an account : " with no advancing end-display.
           accept dest-acc end-accept.
           display "Amount to add: " with no advancing end-display.
           accept amount end-accept.
           add amount to acc-bal (dest-acc) end-add.
           display " " end-display.

       *> Procedure to transfer money between accounts
       transfer-money.
           display "Source account : " with no advancing end-display.
           accept src-acc end-accept.
           display "Dest account : " with no advancing end-display.
           accept dest-acc end-accept.
           display "Amount to transfer: " with no advancing end-display.
           accept amount end-accept.
           display "Account Password: " with no advancing end-display.
           accept passwd-buffer1 end-accept.
           if passwd-buffer1 not = acc-password (src-acc)
               display "Invalid password" end-display
               display " " end-display
               exit paragraph
           end-if
           if amount > acc-bal (src-acc)
               display "Insufficient funds" end-display
               display " " end-display
               exit paragraph
           end-if
           if amount + acc-bal (dest-acc) > 999999999.99
               display "Destination account balance limit reached"
               end-display
               display " " end-display
               exit paragraph
           end-if
           subtract amount from acc-bal (src-acc) end-subtract.
           add amount to acc-bal (dest-acc) end-add.
           display " " end-display.

       *> Procedure to end the program
       end-prog.
           display "Ending program" end-display.

       end program my_bank.
