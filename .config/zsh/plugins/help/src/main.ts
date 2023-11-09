import OpenAI from 'openai';
import { echo, $, argv } from 'zx';
import { API_KEY } from './env';

const openai = new OpenAI({
	apiKey: API_KEY,
});

async function main() {
	const { _: userMessages, verbose } = argv;
	$.verbose = verbose ?? false;

	const userMessage = userMessages.join('\n');

	if (userMessage.length === 0) {
		console.error('Ask me a question!');
		return;
	}

	const systemMessage = `
I am having trouble creating a one-liner in ShellScript. Please answer with the following conditions.

1. Please answer in the format below. Responses in any other format will not be evaluated.
\`\`\`
{Insert one-liner here}
\`\`\`
2. Please ensure to provide exactly two examples using the same format.
	`.trim();

	const chatCompletion = await openai.chat.completions.create({
		messages: [
			{ role: 'system', content: systemMessage },
			{ role: 'user', content: userMessage },
		],
		model: 'gpt-4-1106-preview',
	});

	const message = chatCompletion.choices[0].message.content
		?.replace(/\n/g, '')
		?.split('```')
		?.filter((message) => message.length > 0)
		?.map((message) => `$ ${message}`)
		?.join('\n');

	echo(message);
}

await main();
