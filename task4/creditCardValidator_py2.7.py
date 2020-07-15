import re


def main():
    credit_cards = ['42546258776197837', '4215555513331333',
                    '5322-2348-7974 - 3124', '44155x4423332333',
                    '0535372585962598', '4254625873615486',
                    '5535535535553555', '5322-2348-7964-3124']
    for card in credit_cards:
        is_card_valid(card)


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
    pattern = re.compile(r'(?:\d{4}-){3}\d{4}')
    if fullmatch(pattern, card):
        card = card.replace("-", "")
    res_only_digits, content_only_digits = is_only_digits(card)
    res_contain16digits, content_contain16digits = is_contain16digits(card)
    res_start_with_exact, content_start_with_exact = is_start_with_exact(card, ('4', '5', '6'))
    res_consecutive, content_consecutive = is_consecutive(card)
    if res_only_digits and res_contain16digits and res_start_with_exact and res_consecutive:
        print("Credit card: {} is valid".format(card))
    else:
        print("Credit card: {} {} {} {} {}  Invalid".format(card, content_only_digits, content_contain16digits,
                                content_start_with_exact, content_consecutive))


def is_contain16digits(card):
    """

    :param card: (string) with card number to validate
    :return: (bool)
    """
    if len(card) == 16:
        return True, ""
    return False, "Contains more than 16 digits;"


def is_start_with_exact(card, exact_chars):
    """

    :param card: (string) with card number to validate
    :param exact_chars: (tuple) with required chars to start with
    :return: (bool)
    """
    if card[0] in exact_chars:
        return True, ""
    else:
        return False, "Doesn't start with: {};".format(exact_chars)


def is_only_digits(card):
    """

    :param card: (string) with card number to validate
    :return: (bool)
    """
    if card.isdigit():
        return True, ""
    else:
        return False, "Contains non digit characters;"


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
                    return False, "Includes consecutive digits are repeating 4 or more times;"
                count += 1
            else:
                count = 1
    return True, ""


def fullmatch(regex, string, flags=0):
    """Emulate python-3.4 re.fullmatch()."""
    return re.search(regex, string, flags=flags)


if __name__ == '__main__':
    main()
