import re


def main():
    credit_cards = ['42546258776197837', '4215555513331333',
                    '5322-2348-7974 - 3124', '44155x4423332333',
                    '0535372585962598', '4254625873615486',
                    '5535535535553555', '5322-2348-7964-3124']
    for card in credit_cards:
        if is_card_valid(card):
            print("Credit card: {}  is valid".format(card))
        else:
            print("card {} invalid!".format(card))


def is_card_valid(card):
    """
    This function checks card validation with the following characteristics:
    It must start with a 4,5  or 6
    It must contain exactly 16 digits
    It must only consist of digits (0-9)
    It may have digits in groups of 4, separated by one hyphen "-"
    It must NOT use any other separator like ' ' , '_', etc
    It must NOT have 4 or more consecutive repeated digits
    :param card: (string) with card number to validate
    :return: (bool)
    """
    pattern = re.compile(r'(?:\d{4}-?){3}\d{4}')
    if pattern.fullmatch(card):
        card = card.replace("-", "")
    if is_only_digits(card) and is_contain16digits(card) \
            and is_start_with_exact(card, ('4', '5', '6')) and is_consecutive(card):
        return True
    else:
        return False


def is_contain16digits(card):
    """

    :param card: (string) with card number to validate
    :return: (bool)
    """
    if len(card) == 16:
        return True
    print("Card: {} contains more than 16 digits".format(card))
    return False


def is_start_with_exact(card, exact_chars):
    """

    :param card: (string) with card number to validate
    :param exact_chars: (tuple) with required chars to start with
    :return: (bool)
    """
    if card[0] in exact_chars:
        return True
    else:
        print("Card: {} Doesn't start with: {}".format(card, exact_chars,))
        return False


def is_only_digits(card):
    """

    :param card: (string) with card number to validate
    :return: (bool)
    """
    if card.isdigit():
        return True
    else:
        print("Card: {} Contains non digit characters".format(card))
        return False


def is_consecutive(card):
    """
    This function validates consecutive repeated digits
    :param card: (string) with card number to validate
    :return: (bool)
    """
    count = 1
    if len(card) > 1:
        for i in range(1, len(card)):
            if card[i - 1] == card[i]:
                if count >= 4:
                    print("Card: {} includes consecutive digits are repeating 4 or more times".format(card))
                    return False
                count += 1
            else:
                count = 1
    return True


if __name__ == '__main__':
    main()
