#include <stdio.h>

#define max_size 100

int base_array[max_size];
int freaky_array[max_size];
int base_array_length;
int freaky_array_length;

int try_input_base_array() {
	printf("Input array length (0 < length <= %d): ", max_size);
	if (!scanf("%d", &base_array_length)) {
		return 0;
	}

	if(base_array_length < 1 || base_array_length > max_size) {
		return 0;
	}

	printf("Input %d array values: ", base_array_length);
	for(int i = 0; i < base_array_length; ++i) {
		if (!scanf("%d", base_array + i)) {
			return 0;
		}
	}

	return 1;
}

void print_array(int *array, int length) {
	for(int i = 0; i < length; ++i) {
		printf(" %d", array[i]);
	}
}

void fill_freaky_array() {
	int first_positive_value_index = -1;
	for(int i = 0; i < base_array_length; ++i) {
		if (base_array[i] > 0) {
			first_positive_value_index = i;
			break;
		}
	}

	for(int j = base_array_length - 1; j >= 0; --j) {
		if (j == first_positive_value_index) {
			continue;
		}
		freaky_array[freaky_array_length++] = base_array[j];
	}
}

int main() {
	if (!try_input_base_array()) {
		printf("Incorrect length = %d\n", base_array_length);
		return 1;
	}

	fill_freaky_array();

	if (freaky_array_length) {
		printf("Freaky array values:");
		print_array(freaky_array, freaky_array_length);
	} else {
		printf("Freaky array is empty");
	}
	printf("\n");

	return 0;
}
