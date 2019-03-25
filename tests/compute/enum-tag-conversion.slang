// enum-tag-conversion.slang

//TEST(compute):COMPARE_COMPUTE_EX:-slang -compute
//TEST(compute, vulkan):COMPARE_COMPUTE_EX:-vk -compute

// Confirm that a value of `enum` type can have an initializer
// that includes basic operations like type conversion.

enum RoseColors
{
    Red = 16u,
}

int test(int val)
{
	return val + RoseColors.Red;
}

//TEST_INPUT:ubuffer(data=[0 0 0 0], stride=4):dxbinding(0),glbinding(0),out
RWStructuredBuffer<int> outputBuffer;

[numthreads(4, 1, 1)]
void computeMain(uint3 dispatchThreadID : SV_DispatchThreadID)
{
    uint tid = dispatchThreadID.x;

    int val = int(tid);
    val = test(val);

    outputBuffer[tid] = val;
}